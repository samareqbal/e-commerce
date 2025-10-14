import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/circular_icon.dart';

class SProductQuantityWithAddRemove extends StatelessWidget {
  const SProductQuantityWithAddRemove({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SCircularIcon(
          icon: Iconsax.minus,
          height: 32,
          width: 32,
          size: SSizes.iconSm,
          backgroundColor:
          dark ? SColors.darkerGrey : SColors.light,
          color: dark ? SColors.white : SColors.black,
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Text('2', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: SSizes.spaceBtwItems),
        const SCircularIcon(
          icon: Iconsax.add,
          height: 32,
          width: 32,
          size: SSizes.iconSm,
          backgroundColor: SColors.primary,
          color: SColors.white ,
        )
      ],
    );
  }
}