import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class SBoxesShimmer extends StatelessWidget {
  const SBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            /// Three Products
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSizes.spaceBtwItems,),
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSizes.spaceBtwItems,),
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
