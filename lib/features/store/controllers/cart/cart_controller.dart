import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/features/store/controllers/product/variation_controller.dart';
import 'package:upstore/features/store/models/cart_item_model.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/constants/keys.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final _storage =
      GetStorage(AuthenticationRepository.instance.currentUser!.uid);

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  final variationController = VariationController.instance;

  CartController(){
    loadCartItems();
  }

  void loadCartItems(){
    List<dynamic>? storedCartItems = _storage.read(SKeys.cartItemsKey);
    print(storedCartItems);
    if(storedCartItems != null){
      cartItems.assignAll(storedCartItems.map((item) => CartItemModel.fromJson(item as Map<String,dynamic>)));
      cartItems.refresh();
      updateCartTotals();
    }
  }

  void addToCart(ProductModel product) {
    if (productQuantityInCart < 1) {
      SSnackBarHelpers.customToast(message: 'Select Quantity');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariations.value.id.isEmpty) {
      SSnackBarHelpers.customToast(message: 'Select Variation');
      return;
    }

    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariations.value.stock < 1) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Out of Stock', message: 'This variation is out of stock');
        return;
      }
    } else {
      if (product.stock < 1) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Out of Stock', message: 'This product is out of stock');
      }
    }

    CartItemModel selectedCartItems =
        convertToCartItem(product, productQuantityInCart.value);

    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItems.productId &&
        selectedCartItems.variationId == cartItem.variationId);

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItems.quantity;
    } else {
      cartItems.add(selectedCartItems);
    }

    updateCart();

    SSnackBarHelpers.customToast(
        message: 'Your product has been added to the cart');
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (final item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  void saveCartItems() {
    List<Map<String, dynamic>> cartItemsList =
        cartItems.map((item) => item.toJson()).toList();
    _storage.write(SKeys.cartItemsKey, cartItemsList);
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        item.productId == cartItem.productId &&
        item.variationId == cartItem.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        item.productId == cartItem.productId &&
        item.variationId == cartItem.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
        title: 'Remove Product',
        middleText: 'Are you sure you want to remove this product?',
        onConfirm: () {
          cartItems.removeAt(index);
          updateCart();
          SSnackBarHelpers.customToast(message: 'Product removed from cart');
          Get.back();
        },
        onCancel: () {});
  }

  int getProductQuantityInCart(String productId) {
    final itemQuantity = cartItems
        .where((cartItem) => cartItem.productId == productId)
        .fold(
            0, (previousValue, cartItem) => previousValue + cartItem.quantity);
    return itemQuantity;
  }

  int getVariationQuantityInCart(String productId, String variationId){
    CartItemModel quantity = cartItems.firstWhere((item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty()
    );

    return quantity.quantity;
  }

  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void updateAlreadyAddedProductCount(ProductModel product){
    if(product.productType == ProductType.single.toString()){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    }else{
      String variationId = variationController.selectedVariations.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityInCart.value = 0;
      }
    }
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariations.value;
    bool isVariation = variation.id.isNotEmpty;
    String image = isVariation ? variation.image : product.thumbnail;
    double price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0
            ? product.salePrice
            : product.price;

    return CartItemModel(
        productId: product.id,
        quantity: quantity,
        title: product.title,
        brandName: product.brand != null ? product.brand!.name : '',
        image: image,
        price: price,
        selectedVariation: isVariation ? variation.attributeValues : null,
        variationId: variation.id);
  }
}
