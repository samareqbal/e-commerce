import 'package:get/get.dart';
import 'package:upstore/data/repositories/category/category_repository.dart';
import 'package:upstore/data/repositories/product/product_repository.dart';
import 'package:upstore/features/store/controllers/product/product_controller.dart';
import 'package:upstore/features/store/models/category_model.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

import '../../models/product_model.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  final _repository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  RxBool isCategoriesLoading = false.obs;


  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async{
    try{

      isCategoriesLoading.value = true;
      List<CategoryModel> categories = await _repository.getAllCategories();
      allCategories.assignAll(categories);
      featuredCategories.assignAll(categories.where((category) => category.isFeatured && category.parentId.isEmpty));
    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }finally{
      isCategoriesLoading.value = false;
    }
  }

  Future<List<ProductModel>> getCategoryProduct({required String categoryId,int limit = 4}) async {
    try{

      final products = ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;

    }catch(e) {
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }
}