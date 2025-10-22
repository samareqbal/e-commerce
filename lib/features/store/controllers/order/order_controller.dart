import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/authentication_repository.dart';
import 'package:upstore/data/repositories/order/order_repository.dart';
import 'package:upstore/features/personalization/controllers/address_controller.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/controllers/checkout/checkout_controller.dart';
import 'package:upstore/features/store/models/order_model.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/popups/full_screen_loader.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

import '../../../../common/widgets/screens/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/images.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  // final checkoutController = CheckoutController.instance;
  final addressController = AddressController.instance;
  final _repository = Get.put(OrderRepository());

  Future<void> processOrder(double totalAmount) async {
    try {
      SFullScreenLoader.openLoadingDialog('Processing your order...');

      String userId = AuthenticationRepository.instance.currentUser!.uid;
      if (userId.isEmpty) return;

      OrderModel order = OrderModel(
          id: UniqueKey().toString(),
          status: OrderStatus.pending,
          items: cartController.cartItems.toList(),
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          userId: userId,
          paymentMethod: CheckoutController.instance.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now());

      await _repository.saveOrder(order);

      cartController.clearCart();

      Get.to(() => SuccessScreen(
          title: 'Payment Success',
          subTitle: 'Item will be shipped soon',
          image: SImages.successfulPaymentIcon,
          onTap: () => Get.offAll(() => NavigationMenu())));
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(
          title: 'Order Failed', message: e.toString());
    }
  }

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = _repository.fetchUserOrders();
      return orders;
    } catch (e) {
      SSnackBarHelpers.errorSnackBar(title: 'Unable to fetch orders');
      return [];
    }
  }
}
