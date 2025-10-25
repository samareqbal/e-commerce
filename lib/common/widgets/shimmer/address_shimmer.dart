import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class SAddressShimmer extends StatelessWidget {
  const SAddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(height: SSizes.spaceBtwItems),
        itemCount: 4,
        itemBuilder: (context, index) => const SShimmerEffect(width: double.infinity, height: 150)
    );
  }
}
