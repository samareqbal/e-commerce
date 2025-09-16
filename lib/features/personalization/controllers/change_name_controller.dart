import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/user/user_repository.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';
import 'package:upstore/navigation_menu.dart';
import 'package:upstore/utils/helpers/network_manager.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class ChangeNameController extends GetxController{
  static ChangeNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;

  final updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initialiseNames();
  }

  void initialiseNames(){
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }


  Future<void> updateUserName() async{
    try{
      
      SFullScreenLoader.openLoadingDialog("We are updating your information...");

      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      if(!updateUserFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }


      Map<String, dynamic> map = {'firstName': firstName.text.trim(), 'lastName' : lastName.text.trim()};
      await _userRepository.updateSingleField(map);


      _userController.user.value.firstName = firstName.text.trim();
      _userController.user.value.lastName = lastName.text.trim();

      SFullScreenLoader.stopLoading();

      Get.offAll(() => NavigationMenu());
      
      SSnackBarHelpers.successSnackBar(title: 'Congratulations', message: 'Your name has been updated');

      
    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Update Name Failed", message: e.toString());
    }
  }
}