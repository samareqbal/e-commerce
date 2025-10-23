import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/data/services/stripe_services.dart';
import 'package:upstore/features/store/controllers/order/order_controller.dart';
import 'package:upstore/features/store/controllers/promo_code/promo_code_controller.dart';
import 'package:upstore/features/store/models/payment_method_model.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  final _orderController = Get.put(OrderController());
  final _stripeServices = Get.put(StripeServices());
  final isPaymentProcessing = false.obs;


  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Cash on Delivery', image: SImages.codIcon, paymentMethod: PaymentMethods.cashOnDelivery);
    super.onInit();
  }

  Future<void> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(SSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SSectionHeading(
                        title: 'Select Payment Method',
                        showActionButton: false),
                    const SizedBox(height: SSizes.spaceBtwSections),
                    SPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Cash on Delivery',
                            image: SImages.codIcon,
                            paymentMethod: PaymentMethods.cashOnDelivery)),
                    const SizedBox(height: SSizes.spaceBtwItems/2),
                    SPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Credit/Debit Card',
                            image: SImages.creditCard,
                            paymentMethod: PaymentMethods.creditCard)),
                    const SizedBox(height: SSizes.spaceBtwItems/2),
                    SPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Paytm',
                            image: SImages.paytm,
                            paymentMethod: PaymentMethods.paytm)),
                    const SizedBox(height: SSizes.spaceBtwItems/2),
                    SPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Google Pay',
                            image: SImages.googlePay,
                            paymentMethod: PaymentMethods.googlePay)),
                    const SizedBox(height: SSizes.spaceBtwItems/2),
                    // SPaymentTile(
                    //     paymentMethod: PaymentMethodModel(
                    //         name: 'Apple Pay',
                    //         image: SImages.applePay,
                    //         paymentMethod: PaymentMethods.applePay)),
                    // const SizedBox(height: SSizes.spaceBtwItems/2),
                    SPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'PayPal',
                            image: SImages.paypal,
                            paymentMethod: PaymentMethods.paypal)),
                    const SizedBox(height: SSizes.spaceBtwSections),
                  ],
                ),
              ),
            ));
  }

  Future<void> checkout(double totalAmount) async {
    try{

      isPaymentProcessing.value = true;
      PaymentMethods paymentMethods = selectedPaymentMethod.value.paymentMethod;

      switch(paymentMethods){
        case PaymentMethods.creditCard:
          await _stripeServices.initPaymentSheet('USD', totalAmount.toInt());
          await _stripeServices.showPaymentSheet();
        case PaymentMethods.cashOnDelivery:
          break;
        default:
          throw 'Payment method not supported';
      }
      isPaymentProcessing.value = false;
      await _orderController.processOrder(totalAmount);

      await PromoCodeController.instance.decreaseNoOfPromoCodes();

      await PromoCodeController.instance.addUserToPromoCode();

    }catch(e){
      isPaymentProcessing.value = false;
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }
}


