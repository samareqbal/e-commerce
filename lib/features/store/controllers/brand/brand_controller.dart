import 'package:get/get.dart';
import 'package:upstore/data/repositories/brand/brand_repository.dart';
import 'package:upstore/data/repositories/product/product_repository.dart';
import 'package:upstore/features/store/models/brand_model.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands() async {
    try{

      isLoading.value =  true;

      List<BrandModel> allBrands = await _repository.fetchBrands();
      this.allBrands.assignAll(allBrands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).toList());

    }catch (e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getBrandProducts(String brandId, {int limit = -1})async {
    try{

      List<ProductModel> products = await ProductRepository.instance.getProductsForBrands(brandId: brandId,limit: limit);
      return products;
      
    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try{
      List<BrandModel> brands = await _repository.fetchBrandsForCategory(categoryId);
      return brands;
    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }
}