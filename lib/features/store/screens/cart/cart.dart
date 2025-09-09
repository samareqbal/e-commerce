import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/common/widgets/images/rounded_image.dart';
import 'package:upstore/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:upstore/common/widgets/texts/product_price_text.dart';
import 'package:upstore/common/widgets/texts/product_title_text.dart';
import 'package:upstore/features/store/screens/cart/widgets/cart_items.dart';
import 'package:upstore/features/store/screens/checkout/checkout.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../common/widgets/products/cart/product_quantity_with_add_remove.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
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




