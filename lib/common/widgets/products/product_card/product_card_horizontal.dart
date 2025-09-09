import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:upstore/common/widgets/texts/product_price_text.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../icons/circular_icon.dart';
import '../../images/rounded_image.dart';
import '../../texts/product_title_text.dart';

class SProductCardHorizontal extends StatelessWidget {
  const SProductCardHorizontal({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(SSizes.productImageRadius),
          color: dark ? SColors.darkerGrey : SColors.grey),
      child: Row(
        children: [
          SRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(SSizes.sm),
            backgroundColor: dark ? SColors.dark : SColors.light,
            child: Stack(
              children: [
                SizedBox(
                    width:120,
                    height: 120,
                    child: SRoundedImage(
                        imageUrl: SImages.productImage1)),

                Positioned(
                  top: 12.0,
                  child: SRoundedContainer(
                    radius: SSizes.sm,
                    backgroundColor: SColors.yellow.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: SSizes.sm, vertical: SSizes.xs),
                    child: Text("20%",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: SColors.black)),
                  ),
                ),

                //Favourite button
                Positioned(
                    right: 0,
                    top: 0,
                    child: SCircularIcon(
                        icon: Iconsax.heart5, color: Colors.red))
              ],
            ),
          ),
          SizedBox(
            width: 170,
            child: Padding(
              padding: const EdgeInsets.only(left: SSizes.sm,top: SSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SProductTitleText(title: 'Blue Bata Shoes',smallSize: true),
                      SizedBox(height: SSizes.spaceBtwItems/2),
                      SBrandTitleWithVerifyIcon(title: 'Bata')
                    ],
                  ),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: SProductPriceText(price: '650')),
                      Container(
                        width: SSizes.iconLg * 1.2,
                        height: SSizes.iconLg * 1.2,
                        decoration: BoxDecoration(
                            color: SColors.primary,
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                Radius.circular(SSizes.productImageRadius),
                                topLeft: Radius.circular(SSizes.cardRadiusMd))),
                        child: Icon(Iconsax.add, color: SColors.white),
                      )
                    ],
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}