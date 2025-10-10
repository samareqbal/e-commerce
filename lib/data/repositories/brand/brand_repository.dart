import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/data/services/cloudinary_services.dart';
import 'package:upstore/features/store/models/branc_category_model.dart';
import 'package:upstore/features/store/models/brand_model.dart';
import 'package:upstore/utils/constants/keys.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for (final brand in brands) {
        File file = await SHelperFunctions.assetToFile(brand.image);

        dio.Response response =
            await _cloudinaryServices.uploadImage(file, SKeys.brandsFolder);
        if (response.statusCode == 200) {
          brand.image = response.data['url'];
        }

        await _db
            .collection(SKeys.brandsCollection)
            .doc(brand.id)
            .set(brand.toJson());

        print('Brand ${brand.name} uploaded');
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

  Future<List<BrandModel>> fetchBrands() async {
    try{

      final query = await _db.collection(SKeys.brandsCollection).get();

      if(query.docs.isNotEmpty){
        List<BrandModel> brands = query.docs.map((brand) => BrandModel.fromSnapshot(brand)).toList();

        return brands;
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
  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try{

      final query = await _db.collection(SKeys.brandCategoryCollection).where('categoryId', isEqualTo: categoryId).get();

      List<BrandCategoryModel> brandCategories = query.docs.map((doc) => BrandCategoryModel.fromSnapshot(doc)).toList();


      List<String> brandIds = brandCategories.map((brandCategory) => brandCategory.brandId).toList();

      final brandQuery = await _db.collection(SKeys.brandsCollection).where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      List<BrandModel> brands = brandQuery.docs.map((brand) => BrandModel.fromSnapshot(brand)).toList();

      return brands;

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
}
