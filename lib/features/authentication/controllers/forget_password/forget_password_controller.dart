import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/features/authentication/screens/forget_password/reset_password.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/snackbar_helpers.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  ///Send email to forgot password
  Future<void> sendPasswordResetEmail() async {
    try{

      SFullScreenLoader.openLoadingDialog('Processing your request...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if(!forgetPasswordFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      SFullScreenLoader.stopLoading();
      
      SSnackBarHelpers.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password');

      Get.to(() => ResetPasswordScreen(email: email.text.trim()));

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  ///Send email to forgot password
  Future<void> resendPasswordResetEmail() async {
    try{

      SFullScreenLoader.openLoadingDialog('Processing your request...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      SFullScreenLoader.stopLoading();

      SSnackBarHelpers.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password');

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}