import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/product/image_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/features/store/models/product_variation_model.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  RxMap selectedAttributes = {}.obs;

  Rx<ProductVariationModel> selectedVariations =
      ProductVariationModel.empty().obs;
  RxString variationStockStatus = ''.obs;


  /// Select Attribute and Variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue){
    try{
      Map<String, dynamic> selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
      selectedAttributes[attributeName] = attributeValue;
      this.selectedAttributes[attributeName] = attributeValue; // i.e: selectedAttribute['Color'] : 'Green'

      ProductVariationModel selectedVariation = product.productVariations!.firstWhere((variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),orElse: () => ProductVariationModel.empty(),);

      // Show the selected variation image as a Main Image
      if(selectedVariation.image.isNotEmpty){
        ImageController.instance.selectedProductImage.value = selectedVariation.image;
      }

      // Show selected variation quantity already in the cart
      // if(selectedVariation.id.isNotEmpty){
      //   final cartController = CartController.instance;
      //   cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
      // }

      // Assign Selected Variation to Rx
      selectedVariations.value = selectedVariation;
      getProductVariationStockStatus();
    }catch(e){
      if(e.toString() == 'Bad state: No element'){
        SSnackBarHelpers.errorSnackBar(title: 'Oh Snap!', message: 'Product is not available');
      }

    }

  }

  /// Check if selected attributes matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){
    // if selectedAttributes contains 3 attributes and current variation contains 2 then return
    if(variationAttributes.length != selectedAttributes.length) return false ;

    // If any of the attribute is different then return e.g [Green, Large] != [Green, Small]
    for(final key in variationAttributes.keys){
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// Check Attribute availability / Stock in variation
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName){
    // Pass the variation to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variations.where((variation) =>
    variation.attributeValues[attributeName]!.isNotEmpty && variation.attributeValues[attributeName] != null && variation.stock > 0
    ).map((variation) =>  variation.attributeValues[attributeName]
    ).toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice(){
    return (selectedVariations.value.salePrice > 0 ? selectedVariations.value.salePrice : selectedVariations.value.price).toStringAsFixed(0);
  }

  /// Check product variation stock status
  void getProductVariationStockStatus(){
    variationStockStatus.value = selectedVariations.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// Reset Selected Attributes when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariations.value = ProductVariationModel.empty();
  }

  // void onAttributeSelected(
  //     ProductModel product, attributeName, attributeValue) {
  //   Map<String, dynamic> selectedAttributes =
  //       Map<String, dynamic>.from(this.selectedAttributes);
  //
  //   selectedAttributes[attributeName] = attributeValue;
  //
  //   this.selectedAttributes[attributeName] = attributeValue;
  //
  //   ProductVariationModel selectedVariation = product.productVariations!
  //       .firstWhere((variation) => isSameAttributeValues(
  //           variation.attributeValues, selectedAttributes), orElse: () => ProductVariationModel.empty());
  //
  //   if (selectedVariation.image.isNotEmpty) {
  //     ImageController.instance.selectedProductImage.value =
  //         selectedVariation.image;
  //   }
  //
  //   selectedVariations(selectedVariation);
  //
  //   getProductVariationStockStatus();
  // }
  //
  // bool isSameAttributeValues(Map<String, dynamic> selectedAttributes,
  //     Map<String, dynamic> variationAttribute) {
  //   if (variationAttribute.length != selectedAttributes.length) {
  //     return false;
  //   }
  //
  //   for (final key in variationAttribute.keys) {
  //     if (variationAttribute[key] != selectedAttributes[key]) {
  //       return false;
  //     }
  //   }
  //
  //   return true;
  // }
  //
  // void getProductVariationStockStatus() {
  //   variationStockStatus.value =
  //       selectedVariations.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  // }
  //
  // Set<String?> getAttributeAvailabilityInVariation(
  //     List<ProductVariationModel> variations, String attributeName) {
  //   final availableAttributeValues = variations
  //       .where((variation) =>
  //           variation.attributeValues[attributeName]!.isNotEmpty &&
  //           variation.attributeValues[attributeName] != null &&
  //           variation.stock > 0)
  //       .map((variation) => variation.attributeValues[attributeName])
  //       .toSet();
  //
  //   return availableAttributeValues;
  // }
}
