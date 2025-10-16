import 'package:get/get.dart';
import 'package:upstore/features/personalization/controllers/address_controller.dart';
import 'package:upstore/features/store/controllers/product/variation_controller.dart';
import 'package:upstore/utils/helpers/network_manager.dart';

import '../features/store/controllers/checkout/checkout_controller.dart';

class SBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
    Get.put(AddressController());
  }
}