import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/loaders/circular_loader.dart';
import 'package:upstore/data/repositories/address/address_repository.dart';
import 'package:upstore/features/personalization/models/address_model.dart';
import 'package:upstore/utils/helpers/network_manager.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final postalCode = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> addNewAddress() async {
    try {
      SFullScreenLoader.openLoadingDialog('Storing Address...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.errorSnackBar(
            title: 'Failed', message: 'Check your Internet Connectivity');
        return;
      }

      if (!formKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      AddressModel address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          postalCode: postalCode.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          country: country.text.trim(),
          dateTime: DateTime.now());
      
      String addressId = await _repository.addAddress(address);

      address.id = addressId;

      selectAddress(address);
      
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully');

      refreshData.toggle();

      resetFormFields();

      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);

    } catch (e) {
      
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }

  void resetFormFields(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();

    formKey.currentState!.reset();
  }

  Future<List<AddressModel>> getAllAddress() async {
    try{

      List<AddressModel> address = await _repository.fetchUserAddress();
      selectedAddress.value = address.firstWhere((address) => address.selectedAddress, orElse: AddressModel.empty);
      return address;


    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  Future<void> selectAddress(AddressModel address) async {
    try{

      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const SCircularLoader()
      );

      if(selectedAddress.value.id.isNotEmpty){
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      address.selectedAddress = true;
      selectedAddress.value = address;

      await _repository.updateSelectedField(selectedAddress.value.id, true);

      Get.back();

    }catch(e){
      Get.back();
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }
}
