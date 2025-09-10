import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/screens/success_screen.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/utils/constants/texts.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

import '../../../../utils/constants/images.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  //Send email verification link to current user
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SSnackBarHelpers.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email');
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }


  // Timer to automatically redirect on email verification screen
  void setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();

      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            title: STexts.accountCreatedTitle,
            subTitle: STexts.accountCreatedSubTitle,
            image: SImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  //manually check if email is verified or not
  Future<void> checkEmailVerificationStatus() async {
     try{
       final currentUser = FirebaseAuth.instance.currentUser;
       if(currentUser != null && currentUser.emailVerified){
         Get.off(() => SuccessScreen(
             title: STexts.accountCreatedTitle,
             subTitle: STexts.accountCreatedSubTitle,
             image: SImages.successfulPaymentIcon,
             onTap: () => AuthenticationRepository.instance.screenRedirect()));
       }
     }catch(e){
       SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
     }
  }
}
