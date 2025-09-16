import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/data/repositories/user/user_repository.dart';
import 'package:upstore/features/authentication/screens/login/login.dart';
import 'package:upstore/features/personalization/screens/edit_profile/widgets/reauthenticate_user_form.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';
import 'package:dio/dio.dart' as dio;


import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/snackbar_helpers.dart';
import '../../authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthenticateFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = true.obs;

  final localStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {

      await fetchUserDetails();

      if(user.value.id.isEmpty){
        final nameParts = UserModel.nameParts(userCredential.user!.displayName);
        final userName = '${userCredential.user!.displayName}1234';

        UserModel userModel = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: userName,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '');

        _userRepository.saveUserRecord(userModel);
      }

    } catch (e) {
      SSnackBarHelpers.warningSnackBar(
          title: 'Data not Saved',
          message: 'Something went wrong while saving your information');
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      UserModel user = await _userRepository.fetchUserDetails();
      this.user.value = user;
    } catch (e) {
      user.value = UserModel.empty();
    } finally {
      profileLoading.value = false;
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(SSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account permanently?',
        confirm: ElevatedButton(
            onPressed: () => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: BorderSide(color: Colors.red)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:SSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ));
  }

  Future<void> deleteUserAccount()async{
    try{

      SFullScreenLoader.openLoadingDialog('Processing...');

      final authenticationRepository = AuthenticationRepository.instance;
      final provider = authenticationRepository.currentUser!.providerData.map((e) => e.providerId).first;

      if(provider == 'google.com'){
        await authenticationRepository.googleSignIn();
        await authenticationRepository.deleteAccount();
        await localStorage.erase();

        SFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());

      }else if(provider == 'password'){
        SFullScreenLoader.stopLoading();
        Get.to(() => ReAuthenticateUserForm());

      }

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }


  Future<void> reAuthenticateUser()async{
    try{

      SFullScreenLoader.openLoadingDialog('Processing...');

      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if(!reAuthenticateFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateUserWithEmailAndPassword(email.text.trim(), password.text.trim());

      await AuthenticationRepository.instance.deleteAccount();

      await localStorage.erase();

      SFullScreenLoader.stopLoading();

      Get.offAll(() => LoginScreen());

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> updateUserProfilePicture() async {
    try{

      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);

      if(image == null){
        return;
      }

      File file = File(image.path);

      dio.Response response = await _userRepository.uploadImage(file);

      if(response.statusCode == 200){

        final data = response.data;
        final imageUrl = data['url'];
        final publicId = data['public_id'];

        await _userRepository.updateSingleField({'profilePicture': imageUrl, 'publicId': publicId});

        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;

        user.refresh();

        SSnackBarHelpers.successSnackBar(title: 'Congratulations', message: 'Profile picture updated successfully');

      }else{
        throw 'Failed to upload profile picture. Please try again';
      }

    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }
}
