import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/features/store/models/order_model.dart';

import '../../../utils/constants/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> saveOrder(OrderModel order) async {
    try{

      await _db.collection(SKeys.userCollection).doc(order.userId).collection(SKeys.ordersCollection).add(order.toJson());

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

  Future<List<OrderModel>> fetchUserOrders() async {
    try{

      final userId = AuthenticationRepository.instance.currentUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information';

      final query = await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.ordersCollection).get();

      if(query.docs.isNotEmpty){
        List<OrderModel> orders = query.docs.map((order) => OrderModel.fromSnapshot(order)).toList();
        return orders;
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