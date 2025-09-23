import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/data/services/cloudinary_services.dart';
import 'package:upstore/features/authentication/models/user_model.dart';
import 'package:upstore/utils/constants/apis.dart';
import 'package:upstore/utils/constants/keys.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  //Save User Data
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db
          .collection(SKeys.userCollection)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
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

  //Fetch User Data
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection(SKeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        UserModel user = UserModel.fromSnapshot(documentSnapshot);
        return user;
      }

      return UserModel.empty();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
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

  //update single field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection(SKeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
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

  //Remove user record
  Future<void> removeUserRecord(String id) async {
    try {
      await _db.collection(SKeys.userCollection).doc(id).delete();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
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

  //Upload profile pic
  Future<dio.Response> uploadImage(File image) async {
    try{

      dio.Response response = await _cloudinaryServices.uploadImage(image, SKeys.profileFolder);
      return response;

    }catch(e){
      throw 'Failed to upload profile picture. Please try again';
    }
  }

  //delete profile pic
  Future<dio.Response> deleteImage(String publicId) async {
    try{

      dio.Response response = await _cloudinaryServices.deleteImage(publicId);

      return response;

    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}
