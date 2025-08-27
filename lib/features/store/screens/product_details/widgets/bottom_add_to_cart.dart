import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

class SBottomAddToCart extends StatelessWidget {
  const SBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
          color: dark ? SColors.darkerGrey : SColors.light,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SSizes.cardRadiusLg),
              topRight: Radius.circular(SSizes.cardRadiusLg))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SSizes.defaultSpace, vertical: SSizes.defaultSpace / 2),
        child: Row(
          children: [
            //Decrement Icon
            SCircularIcon(
              icon: Iconsax.minus,
              backgroundColor: SColors.darkGrey,
              height: 40,
              width: 40,
              color: SColors.white,
            ),

            const SizedBox(width: SSizes.spaceBtwItems),

            //Counter
            Text('2', style: Theme.of(context).textTheme.titleSmall),

            const SizedBox(width: SSizes.spaceBtwItems),

            //Increment Icon
            SCircularIcon(
              icon: Iconsax.add,
              backgroundColor: SColors.black,
              height: 40,
              width: 40,
              color: SColors.white,
            ),

            Spacer(),

            ElevatedButton(
              onPressed: () {},
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
    );
  }
}
