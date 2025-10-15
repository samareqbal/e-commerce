import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/features/personalization/models/address_model.dart';
import 'package:upstore/utils/constants/keys.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();

   final _db = FirebaseFirestore.instance;

   Future<String> addAddress(AddressModel address) async {
     try{

       final userId = AuthenticationRepository.instance.currentUser!.uid;
       final currentAddress = await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.addressCollection).add(address.toJson());


       return currentAddress.id;

     }on FirebaseException catch (e) {
       throw SFirebaseExceptions(e.code).message;
     } on FormatException catch (_) {
       throw const SFormatExceptions();
     } on PlatformException catch (e) {
       throw SPlatformExceptions(e.code).message;
     } catch (e) {
       throw 'Something went wrong while saving address. Please try again';
     }
   }



   Future<List<AddressModel>> fetchUserAddress() async {
     try{

       final userId = AuthenticationRepository.instance.currentUser!.uid;

       if(userId.isEmpty) throw 'User not found. Please try again';

       final query = await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.addressCollection).get();

       if(query.docs.isNotEmpty){
         List<AddressModel> address = query.docs.map((doc) => AddressModel.fromDocumentSnapshot(doc)).toList();

         return address;
       }

       return [];

     }on FirebaseException catch (e) {
       throw SFirebaseExceptions(e.code).message;
     } on FormatException catch (_) {
       throw const SFormatExceptions();
     } on PlatformException catch (e) {
       throw SPlatformExceptions(e.code).message;
     } catch (e) {
       throw 'Unable to find address. Please try again';
     }
   }

   Future<void> updateSelectedField(String addressId, bool selected) async {
     try{

       final userId = AuthenticationRepository.instance.currentUser!.uid;
       await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.addressCollection).doc(addressId).update({'selectedAddress': selected});

     }on FirebaseException catch (e) {
       throw SFirebaseExceptions(e.code).message;
     } on FormatException catch (_) {
       throw const SFormatExceptions();
     } on PlatformException catch (e) {
       throw SPlatformExceptions(e.code).message;
     } catch (e) {
       throw 'Unable to find address. Please try again';
     }
   }
}