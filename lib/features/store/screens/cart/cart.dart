import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/store/screens/cart/widgets/cart_items.dart';
import 'package:upstore/features/store/screens/checkout/checkout.dart';
import 'package:upstore/utils/constants/sizes.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: SPadding.screenPadding,
        child: SCartItems(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: SElevatedButton(onPressed: () => Get.to(() => CheckoutScreen()), child: Text('Checkout')),
      ),
    );
  }
}




