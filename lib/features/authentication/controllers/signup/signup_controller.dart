import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/data/repositories/user/user_repository.dart';
import 'package:upstore/features/authentication/models/user_model.dart';
import 'package:upstore/features/authentication/screens/signup/verify_email.dart';
import 'package:upstore/utils/helpers/network_manager.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final signupFormKey = GlobalKey<FormState>();


  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  RxBool privacyPolicy = false.obs;

  //register user with email and password
  Future<void> registerUser() async {
    try {

      //Start loading
      SFullScreenLoader.openLoadingDialog(
          'We are processing your information...');

      //check internet
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //check privacy policy
      if (!privacyPolicy.value) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(
            title: 'Accept privacy policy',
            message:
                'In order to create account you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      //Form validation



      //register user
      UserCredential userCredential = await AuthenticationRepository.instance.registerUser(
          email.text.trim(), password.text.trim());

      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text,
          lastName: lastName.text,
          username: '${firstName.text}${lastName.text}123',
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);

      SSnackBarHelpers.successSnackBar(title: 'Congratulations!', message: 'Your account has been created! Verify email to continue');

      SFullScreenLoader.stopLoading();

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
