import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';
import 'package:upstore/features/store/screens/brands/brand_products.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../features/store/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/rounded_container.dart';
import 'brand_card.dart';

class SBrandShowCase extends StatelessWidget {
  const SBrandShowCase({
    super.key,
    required this.images,
    required this.brand,
  });

  final List<String> images;

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
      child: SRoundedContainer(
        showBorder: true,
        borderColor: SColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SSizes.md),
        margin: const EdgeInsets.only(bottom: SSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SBrandCard(showBorder: false, brand: brand),
            Row(
                children:
                    images.map((image) => buildBrandImage(dark, image)).toList())
          ],
        ),
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
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          progressIndicatorBuilder: (context, url, progress) {
            return const SShimmerEffect(width: 100, height: 100);
          },
        ),
      ),
    );
  }
}
