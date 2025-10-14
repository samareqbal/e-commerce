import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:upstore/data/services/cloudinary_services.dart';
import 'package:upstore/features/store/models/branc_category_model.dart';
import 'package:upstore/features/store/models/category_model.dart';
import 'package:upstore/features/store/models/product_category_model.dart';
import 'package:upstore/utils/constants/keys.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try{

      for(final category in categories){

        File file = await SHelperFunctions.assetToFile(category.image);
        dio.Response response = await _cloudinaryServices.uploadImage(file, SKeys.categoryFolder);

        if(response.statusCode == 200){
          category.image = response.data['url'];
        }

        await _db.collection(SKeys.categoryCollection).doc(category.id).set(category.toJson());

        print('Category Uploaded: ${category.name}');
      }

    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadBrandCategory(List<BrandCategoryModel> brandCategories) async {
    try{

      for(final brandCategory in brandCategories){
        await _db.collection(SKeys.brandCategoryCollection).doc().set(brandCategory.toJson());
      }

    }on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadProductCategory(List<ProductCategoryModel> productCategories) async {
    try{

      for(final productCategory in productCategories){
        await _db.collection(SKeys.productCategoryCollection).doc().set(productCategory.toJson());
        print('Uploaded ${productCategory.productId}');
      }

    }on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  Future<List<CategoryModel>> getAllCategories() async {
    try{

      final query = await _db.collection(SKeys.categoryCollection).get();

      if(query.docs.isNotEmpty){
        List<CategoryModel> categories = query.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
        return categories;
      }

      return [];

    }on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



  
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try{

      final query = await _db.collection(SKeys.categoryCollection).where('parentId', isEqualTo: categoryId).get();

      if(query.docs.isNotEmpty){
        List<CategoryModel> categories = query.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
        return categories;
      }

      return [];

    }on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}