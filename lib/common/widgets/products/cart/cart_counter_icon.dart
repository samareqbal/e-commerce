import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/screens/cart/cart.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class SCartCounterIcon extends StatelessWidget {
  const SCartCounterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = SHelperFunctions.isDarkMode(context);
    final controller = Get.put(CartController());
    return Stack(
      children: [
        //Cart Icon
        IconButton(
            onPressed: () => Get.to(() => CartScreen()),
            icon: const Icon(Iconsax.shopping_bag, color: SColors.light)),

        //Counter Text
        Positioned(
          right: 6.0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                color: dark ? SColors.dark : SColors.light,
                shape: BoxShape.circle),
            child: Center(
                child: Obx(
    () => Text(
                                controller.noOfCartItems.value.toString(),
                                style: Theme.of(context).textTheme.labelLarge!.apply(
                    fontSizeFactor: 0.8,
                    color: dark ? SColors.light : SColors.dark),
                              ),
                )),
          ),
        )
      ],
    );
  }
}
