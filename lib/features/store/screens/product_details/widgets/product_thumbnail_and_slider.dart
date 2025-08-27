import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SProductThumbnailAndSlider extends StatelessWidget {
  const SProductThumbnailAndSlider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Container(
      color: dark ? SColors.darkerGrey : SColors.light,
      child: Stack(
        children: [

          //Thumbnail
          SizedBox(
              height: 400,
              child: Padding(
                  padding: EdgeInsets.all(SSizes.productImageRadius * 2),
                  child: Center(child: Image(image: AssetImage(SImages.productImage15))))
          ),

          Positioned(
            left: SSizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: SSizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) => SRoundedImage(
                    width: 80,
                    backgroundColor: dark ? SColors.dark : SColors.white,
                    padding: EdgeInsets.all(SSizes.sm),
                    border: Border.all(color: SColors.primary),
                    imageUrl: SImages.productImage47),
              ),
            ),
          ),

          SAppBar(
            showBackArrow: true,
            actions: [
              SCircularIcon(
                icon: Iconsax.heart5, color: Colors.red,
              )
            ],
          )
        ],
      ),
    );
  }
}