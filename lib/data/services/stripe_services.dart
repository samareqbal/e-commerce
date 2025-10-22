

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:upstore/utils/constants/apis.dart';

import 'package:dio/dio.dart' as dio;

import '../../utils/constants/keys.dart';

class StripeServices extends GetxController{
  static StripeServices get instance => Get.find();

  final _dio = dio.Dio();

  Future<dynamic> createPaymentIntents(String currency , int amount) async {
    try{
      String url = SApiUrls.stripeCreateIntents;

      final body = {
        'currency': currency,
        'amount': amount,
        'payment_method_types[]' : 'card'
      };

      dio.Response response = await _dio.post(url, data: body, options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${SKeys.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          }
      ));

      if(response.statusCode == 200){
        return response.data;
      }
    }catch(e){
      throw 'Something went wrong while creating payment intents';
    }

  }

  Future<void> initPaymentSheet(String currency , int amount) async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentIntents(currency, amount);

      log(data.toString());

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: true,
          // Main params
          merchantDisplayName: 'Shopping App',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          //customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          // Extra options
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            // currencyCode: 'INR',
            testEnv: true,
          ),
          style: ThemeMode.dark,
        ),
      );

    } catch (e) {
      throw 'Something went wrong while initialising payment sheet';
    }
  }

  Future<void> showPaymentSheet() async {
    try{
      await Stripe.instance.presentPaymentSheet();
    }on StripeException catch (e){
      switch(e.error.code){
        case FailureCode.Canceled:
          throw 'Payment Cancelled';
        case FailureCode.Failed:
          throw 'Payment Failed';
        case FailureCode.Timeout:
          throw 'Payment Timeout';
        case FailureCode.Unknown:
          throw 'Unknown Error';
      }
    }
    catch(e){
      throw 'Something went wrong while showing the payment sheet';
    }
  }

}