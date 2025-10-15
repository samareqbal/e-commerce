import 'package:flutter/material.dart';
import 'package:upstore/features/store/models/cart_item_model.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class SCartItem extends StatelessWidget {
  const SCartItem({
    super.key, required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SRoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(SSizes.sm),
          backgroundColor: dark ? SColors.darkerGrey : SColors.light,
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SBrandTitleWithVerifyIcon(title: cartItem.brandName ?? ''),
                 SProductTitleText(title: cartItem.title, maxLines: 1),
                RichText(
                    text: TextSpan(children: (cartItem.selectedVariation ?? {}).entries.map((item) => TextSpan(children: [
                      TextSpan(
                          text: '${item.key} ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: '${item.value} ',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ])).toList()))
              ],
            ))
      ],
    );
  }
}