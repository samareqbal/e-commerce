import 'package:get/get.dart';
import 'package:upstore/data/repositories/product/product_repository.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/constants/texts.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFeaturedProducts();
    super.onInit();
  }
  
  
  Future<List<ProductModel>> getAllProducts() async {
    try{

      List<ProductModel> products = await _repository.fetchAllProducts();
      return products;

    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  Future<void> getFeaturedProducts() async {
    try {
      isLoading.value = true;

      List<ProductModel> products = await _repository.fetchFeaturedProducts();
      this.products.assignAll(products);
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      List<ProductModel> products =
          await _repository.fetchAllFeaturedProducts();

      return products;
    } catch (e) {

      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }

  String? calculateSalePercentage(double? originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    }

    if (originalPrice! <= 0.0) {
      return null;
    }

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;

    return percentage.toStringAsFixed(1);
  }

  /// get the product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate smallest and largest  price among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${largestPrice.toStringAsFixed(0)} - ${STexts.currency}${smallestPrice.toStringAsFixed(0)}';
      }
    }
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? "In Stock" : "Out of Stock";
  }
}
