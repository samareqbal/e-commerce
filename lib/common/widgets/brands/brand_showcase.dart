import 'package:flutter/material.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../features/store/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/rounded_container.dart';
import 'brand_card.dart';

class SBrandShowCase extends StatelessWidget {
  const SBrandShowCase({
    super.key, required this.images,
  });

  final List<String> images;


  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return SRoundedContainer(
      showBorder: true,
      borderColor: SColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(SSizes.md),
      margin: const EdgeInsets.only(bottom: SSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SBrandCard(showBorder: false, brand: BrandModel.empty()),

          Row(
            children: images.map((image) => buildBrandImage(dark,image)).toList()

          )
        ],
      ),
    );
  }

  Widget buildBrandImage(bool dark, String image) {
    return Expanded(
      child: SRoundedContainer(
            height: 100,
            margin: const EdgeInsets.only(right: SSizes.sm),
            padding: const EdgeInsets.all(SSizes.md),
            backgroundColor: dark ? SColors.darkGrey : SColors.light,
            child: Image(image: AssetImage(image), fit: BoxFit.contain),
          ),
    );
  }
}
