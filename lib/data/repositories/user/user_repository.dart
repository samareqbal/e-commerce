import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/features/authentication/models/user_model.dart';
import 'package:upstore/utils/constants/keys.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //Save User Data
  Future<void> saveUserRecord(UserModel user) async{
    try{

      await _db.collection(SKeys.userCollection).doc(user.id).set(user.toJson());

    }on FirebaseAuthException catch(e){
      throw SFirebaseAuthExceptions(e.code).message;
    }on FirebaseException catch(e){
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch(e){
      throw SFormatExceptions();
    } on PlatformException catch (e){
      throw SPlatformExceptions(e.code).message;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}