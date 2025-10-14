import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/data/repositories/product/product_repository.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class FavouriteController extends GetxController{
  static FavouriteController get instance => Get.find();

  RxMap<String, bool> favourites = <String,bool>{}.obs;
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);


  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  void toggleFavourite(String productId){
    if(favourites.containsKey(productId)){
      favourites.remove(productId);
      saveFavouritesToStorage();
      SSnackBarHelpers.customToast(message: 'Product has been removed from the wishlist');
    }else{
      favourites[productId] = true;
      saveFavouritesToStorage();
      SSnackBarHelpers.customToast(message: 'Product has been added to the wishlist');
    }
  }

  Future<void> initFavourites() async {
    String? encodedFavourites = _storage.read('favourites');
    if(encodedFavourites == null) return;
    Map<String, dynamic> storedFavourites = jsonDecode(encodedFavourites) as Map<String, dynamic>;
    favourites.assignAll(storedFavourites.map((key,value) => MapEntry(key, value as bool)));
  }

  void saveFavouritesToStorage(){
    String encodedMap = jsonEncode(favourites);
    _storage.write('favourites', encodedMap);
  }

  bool isFavourite(String productId){
    return favourites[productId] ?? false;
  }

  Future<List<ProductModel>> getFavouriteProducts() async {
    final productId = favourites.keys.toList();
    return await ProductRepository.instance.getFavouriteProducts(productId);
  }
}