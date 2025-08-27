import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/common/widgets/images/rounded_image.dart';
import 'package:upstore/features/store/screens/product_details/product_details.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../style/shadow.dart';
import '../../texts/brand_title_text.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class SProductCardVertical extends StatelessWidget {
  const SProductCardVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen()),
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: SShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(SSizes.productImageRadius),
          color: dark ? SColors.darkerGrey : SColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Thumbnail , Favorite button , discount tag
            SRoundedContainer(
              width: 180,
              padding: const EdgeInsets.all(SSizes.sm),
              backgroundColor: dark ? SColors.dark : SColors.light,
              child: Stack(
                children: [
                  //Thumbnail
                  Center(child: SRoundedImage(imageUrl: SImages.productImage15)),

                  //Discount tag
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

            const SizedBox(height: SSizes.spaceBtwItems / 2),

            Padding(
              padding: const EdgeInsets.only(left: SSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SProductTitleText(title: "Blue Bata Shoes", smallSize: true),
                  const SizedBox(height: SSizes.spaceBtwItems / 2),
                  SBrandTitleWithVerifyIcon(title: 'Bata'),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: SSizes.sm),
                  child: SProductPriceText(
                    currencySign: '₹',
                    price: '1600.00',
                  ),
                ),
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
        ),
      ),
    );
  }
}
