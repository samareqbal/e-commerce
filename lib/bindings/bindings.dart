import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/product/variation_controller.dart';
import 'package:upstore/utils/helpers/network_manager.dart';

class SBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}