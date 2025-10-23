import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/models/promo_code_model.dart';
import 'package:upstore/utils/constants/keys.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class PromoCodeRepository extends GetxController{
  static PromoCodeRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> uploadPromoCode(List<PromoCodeModel> promoCodes) async {
    try{

      for(final promoCode in promoCodes){
        await _db.collection(SKeys.promoCodesCollection).doc(promoCode.id).set(promoCode.toJson());
        //print('Promo Code uploading: ${promoCode.name}');
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

  Future<PromoCodeModel> fetchSinglePromoCode(String code) async {
    try{

      final query = await _db.collection(SKeys.promoCodesCollection).where('code', isEqualTo: code).get();
      if(query.docs.isNotEmpty){
        PromoCodeModel promoCode = PromoCodeModel.fromSnapshot(query.docs.first);
        return promoCode;
      }

      return PromoCodeModel.empty();

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

  Future<void> updateSingleFieldPromoCode(PromoCodeModel promoCode, String key, dynamic value) async {
    try{
      
      await _db.collection(SKeys.promoCodesCollection).doc(promoCode.id).update({key:value});

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