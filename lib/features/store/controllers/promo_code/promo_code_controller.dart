import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/data/repositories/promo_code/promo_code_repository.dart';
import 'package:upstore/features/store/models/promo_code_model.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/constants/texts.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/snackbar_helpers.dart';
import '../cart/cart_controller.dart';

class PromoCodeController extends GetxController {
  static PromoCodeController get instance => Get.find();

  RxString promoCode = ''.obs;
  RxBool isLoading = false.obs;
  Rx<PromoCodeModel> appliedPromoCode = PromoCodeModel.empty().obs;
  final _repository = Get.put(PromoCodeRepository());
  final controller = CartController.instance;
  final promoCodeTextController = TextEditingController();

  void onPromoChanged(String value) => promoCode.value = value;

  Future<void> applyPromoCode() async {
    try {
      isLoading.value = true;

      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      PromoCodeModel promoCode =
          await _repository.fetchSinglePromoCode(this.promoCode.value);
      if (promoCode.id.isEmpty) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Invalid Promo Code',
            message: 'Please enter a valid promo code');
        return;
      }

      DateTime now = DateTime.now();
      if (promoCode.endDate!.isBefore(now)) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Promo Code expired', message: 'Promo Code is Expired');
        return;
      }

      if (!promoCode.isActive) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Promo Code not active',
            message: 'This promo code is not active');
        return;
      }

      double subTotal = controller.totalCartPrice.value;
      double total = SPricingCalculator.calculateTotalPrice(subTotal, "India");

      if (!(total >= promoCode.minOrderPrice)) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Promo code not applicable',
            message:
                'Minimum order amount must be ${STexts.currency}${promoCode.minOrderPrice.toStringAsFixed(0)} to use this code');
        return;
      }

      if (!(promoCode.noOfPromoCodes > 0)) {
        SSnackBarHelpers.warningSnackBar(
            title: 'Promo Code expired', message: 'Promo Code is Expired');
        return;
      }


      List<String> userIds = promoCode.userIds ?? [];
      String currentUserId = AuthenticationRepository.instance.currentUser!.uid;

      if(userIds.contains(currentUserId)){
        SSnackBarHelpers.warningSnackBar(title: 'Already Applied', message: 'You have already applied this promo code');
        return;
      }

      appliedPromoCode.value = promoCode;
      promoCodeTextController.clear();




    } catch (e) {
      SSnackBarHelpers.errorSnackBar(
          title: "Promo code error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  double calculatePriceAfterDiscount(
      PromoCodeModel promoCode, double totalPrice) {
    if (promoCode.id.isNotEmpty) {
      if (promoCode.discountType == DiscountType.percentage) {
        return SPricingCalculator.calculatePercentageDiscount(
            totalPrice, promoCode.discount);
      } else {
        return SPricingCalculator.calculateFixedDiscount(
            totalPrice, promoCode.discount);
      }
    }
    return totalPrice;
  }

  String getDiscountPrice() {
    if (appliedPromoCode.value.id.isEmpty) return '';

    if (appliedPromoCode.value.discountType == DiscountType.percentage) {
      return '${appliedPromoCode.value.discount}%';
    } else {
      return '${STexts.currency}${appliedPromoCode.value.discount}';
    }
  }

  Future<void> decreaseNoOfPromoCodes() async {
    try {
      if (appliedPromoCode.value.id.isEmpty) return;

      int noOfPromoCodes = appliedPromoCode.value.noOfPromoCodes - 1;

      await _repository.updateSingleFieldPromoCode(
          appliedPromoCode.value, 'noOfPromoCodes', noOfPromoCodes);
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(
          title: 'Promo Code error', message: e.toString());
    }
  }

  Future<void> addUserToPromoCode() async {
    try{

      if(appliedPromoCode.value.id.isEmpty) return;

      List<String> userIds = appliedPromoCode.value.userIds ?? [];
      userIds.add(AuthenticationRepository.instance.currentUser!.uid);
      await _repository.updateSingleFieldPromoCode(appliedPromoCode.value, 'userIds', userIds);
    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
