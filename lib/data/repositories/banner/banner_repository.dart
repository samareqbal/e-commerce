import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/data/services/cloudinary_services.dart';
import 'package:upstore/features/store/models/banner_model.dart';
import 'package:upstore/utils/constants/keys.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());


  Future<void> uploadBanners(List<BannerModel> banners) async {
    try{

      for(final banner in banners){

        File file = await SHelperFunctions.assetToFile(banner.imageUrl);
        dio.Response response =  await _cloudinaryServices.uploadImage(file, SKeys.bannersFolder);

        if(response.statusCode == 200){
          banner.imageUrl = response.data['url'];
        }

        await _db.collection(SKeys.bannerCollection).doc().set(banner.toJson());
      }

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

  Future<List<BannerModel>> fetchActiveBanners() async {
    try{
      final query = await _db.collection(SKeys.bannerCollection).where('active', isEqualTo: true).get();

      if(query.docs.isNotEmpty){
        List<BannerModel> banners = query.docs.map((document) => BannerModel.fromDocument(document)).toList();
        return banners;
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
}