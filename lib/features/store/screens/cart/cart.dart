import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/common/widgets/loaders/animation_loader.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/screens/cart/widgets/cart_items.dart';
import 'package:upstore/features/store/screens/checkout/checkout.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../utils/constants/images.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
        actions: [SCircularIcon(icon: Iconsax.box_remove,onPressed: () => controller.clearCart())],
      ),
      body: Obx(() {
        final emptyWidget = SAnimationLoader(
          text: 'Cart is Empty',
          animation: SImages.cartEmptyAnimation,
          showActionButton: true,
          actionText: "Lets's fill it!",
          onActionPressed: () => Get.back(),
        );
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: SPadding.screenPadding,
            child: SCartItems(),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: SElevatedButton(
              onPressed: () => Get.to(() => CheckoutScreen()),
              child: Text('Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}')),
        );
      }),
    );
  }
}
