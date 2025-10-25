import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';
import 'package:upstore/utils/constants/keys.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/snackbar_helpers.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();



  final loginFormKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordVisible = true.obs;
  RxBool rememberMe = false.obs;

  final localStorage = GetStorage();


  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read(SKeys.rememberMeEmail) ?? '';
    password.text = localStorage.read(SKeys.rememberMePassword) ?? '';
  }


  ///login with email and password
  Future<void> loginWithEmailAndPassword() async {
    try {
      SFullScreenLoader.openLoadingDialog('Logging you in...');

      //check internet
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write(SKeys.rememberMeEmail, email.text.trim());
        localStorage.write(SKeys.rememberMePassword, password.text.trim());
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      SFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(
          title: 'Login Failed', message: e.toString());
    }
  }

  ///google sign in
  Future<void> googleSignIn() async {
    try{
      SFullScreenLoader.openLoadingDialog('Logging you in...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      UserCredential userCredential = await AuthenticationRepository.instance.googleSignIn();

      await Get.put(UserController()).saveUserRecord(userCredential);

      SFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();


    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(
          title: 'Login Failed', message: e.toString());
    }
  }
}
