import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/data/services/cloudinary_services.dart';
import 'package:upstore/utils/constants/keys.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';
import 'package:dio/dio.dart' as dio;

import '../../../features/store/models/product_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for (final product in products) {
        final Map<String, String> uploadedImageMap = {};

        File thumbnail = await SHelperFunctions.assetToFile(product.thumbnail);
        dio.Response response = await _cloudinaryServices.uploadImage(
            thumbnail, SKeys.productsFolder);

        if (response.statusCode == 200) {
          String url = response.data['url'];
          uploadedImageMap[product.thumbnail] = url;
          product.thumbnail = url;
        }

        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrls = [];

          for (final image in product.images!) {
            File imageFile = await SHelperFunctions.assetToFile(image);
            dio.Response response = await _cloudinaryServices.uploadImage(
                imageFile, SKeys.productsFolder);
            if (response.statusCode == 200) {
              imageUrls.add(response.data['url']);
            }
          }

          if (product.productVariations != null &&
              product.productVariations!.isNotEmpty) {
            for (int i = 0; i < product.images!.length; i++) {
              uploadedImageMap[product.images![i]] == imageUrls[i];
            }

            for (final variation in product.productVariations!) {
              final match = uploadedImageMap.entries.firstWhere(
                  (entry) => entry.key == variation.image,
                  orElse: () => const MapEntry('', ''));

              if (match.key.isNotEmpty) {
                variation.image = match.value;
              }
            }
          }

          product.images!.clear();
          product.images!.assignAll(imageUrls);
        }

        await _db
            .collection(SKeys.productsCollection)
            .doc(product.id)
            .set(product.toJson());

        print('Product ${product.id} uploaded');
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

  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final query = await _db
          .collection(SKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
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

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final query = await _db
          .collection(SKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
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

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        List<ProductModel> products = querySnapshot.docs
            .map((document) => ProductModel.fromQuerySnapshot(document))
            .toList();
        return products;
      }

      return [];
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

  Future<List<ProductModel>> getProductsForBrands(
      {required String brandId, int limit = -1}) async {
    try {
      final query = limit == -1
          ? await _db
              .collection(SKeys.productsCollection)
              .where('brand.id', isEqualTo: brandId)
              .get()
          : await _db
              .collection(SKeys.productsCollection)
              .where('brand.id', isEqualTo: brandId)
              .limit(limit)
              .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
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

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      final query = limit == -1
          ? await _db
              .collection(SKeys.productCategoryCollection)
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection(SKeys.productCategoryCollection)
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds =
          query.docs.map((doc) => doc['productId'] as String).toList();

      final productQuery = await _db
          .collection(SKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
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

  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final query = await _db
          .collection(SKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
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
}
