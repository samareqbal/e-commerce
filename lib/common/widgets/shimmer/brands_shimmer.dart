import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class SBrandShimmer extends StatelessWidget {
  const SBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: SSizes.spaceBtwItems),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) => const SShimmerEffect(width: SSizes.brandCardWidth, height: SSizes.brandCardHeight),
    );
  }
}
