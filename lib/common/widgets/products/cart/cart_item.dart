import 'package:flutter/material.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class SCartItem extends StatelessWidget {
  const SCartItem({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SRoundedImage(
          imageUrl: SImages.productImage4a,
          height: 60,
          width: 60,
          padding: EdgeInsets.all(SSizes.sm),
          backgroundColor: dark ? SColors.darkerGrey : SColors.light,
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBrandTitleWithVerifyIcon(title: 'iPhone'),
                SProductTitleText(title: 'iPhone 11 64 Gb', maxLines: 1),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Color ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: 'Green ',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                          text: 'Storage ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: '64GB ',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ]))
              ],
            ))
      ],
    );
  }
}