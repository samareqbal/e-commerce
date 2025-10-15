import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

class SBottomAddToCart extends StatelessWidget {
  const SBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = CartController.instance;

    controller.updateAlreadyAddedProductCount(product);
    return Container(
      decoration: BoxDecoration(
          color: dark ? SColors.darkerGrey : SColors.light,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SSizes.cardRadiusLg),
              topRight: Radius.circular(SSizes.cardRadiusLg))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SSizes.defaultSpace, vertical: SSizes.defaultSpace / 2),
        child: Obx(
          () => Row(
            children: [
              //Decrement Icon
              SCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: SColors.darkGrey,
                height: 40,
                width: 40,
                color: SColors.white,
                onPressed:  controller.productQuantityInCart.value < 1 ? null : () => controller.productQuantityInCart.value -= 1,
              ),

              const SizedBox(width: SSizes.spaceBtwItems),

              //Counter
              Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),

              const SizedBox(width: SSizes.spaceBtwItems),

              //Increment Icon
              SCircularIcon(
                icon: Iconsax.add,
                backgroundColor: SColors.black,
                height: 40,
                width: 40,
                color: SColors.white,
                onPressed: () => controller.productQuantityInCart.value += 1,
              ),

              const Spacer(),

              ElevatedButton(
                onPressed:  controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(SSizes.md),
                    backgroundColor: SColors.black,
                    side: BorderSide(color: SColors.black)),
                child: Row(
                  children: [
                    Icon(Iconsax.shopping_bag),
                    const SizedBox(width: SSizes.spaceBtwItems / 2),
                    Text('Add to cart'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
