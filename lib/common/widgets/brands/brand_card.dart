import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/rounded_container.dart';
import '../images/rounded_image.dart';
import '../texts/brand_title_with_verify_icon.dart';

class SBrandCard extends StatelessWidget {
  const SBrandCard({
    super.key,
    this.showBorder = true
  });

  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return SRoundedContainer(
      height: SSizes.brandCardHeight,
      backgroundColor: Colors.transparent,
      showBorder: showBorder,
      padding: EdgeInsets.all(SSizes.sm),
      child: Row(
        children: [
          //Brand logo
          Flexible(
              child: SRoundedImage(
                  imageUrl: SImages.adidasLogo,
                  backgroundColor: Colors.transparent)),

          const SizedBox(width: SSizes.spaceBtwItems / 2),

          //Brand name and verify logo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SBrandTitleWithVerifyIcon(
                    title: 'Adidas', brandTextSize: TextSizes.large),
                Text("172 products",
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis)
              ],
            ),
          )
        ],
      ),
    );
  }
}
