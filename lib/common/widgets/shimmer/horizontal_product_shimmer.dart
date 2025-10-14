import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class SHorizontalProductShimmer extends StatelessWidget {
  const SHorizontalProductShimmer({super.key,this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: SSizes.spaceBtwItems),
        itemCount: itemCount,
        itemBuilder: (context, index) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// Image
            SShimmerEffect(width: 120, height: 120),
            SizedBox(width: SSizes.spaceBtwItems),


            /// Text
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SSizes.spaceBtwItems),

                    /// Title
                    SShimmerEffect(width: 160, height: 15),
                    SizedBox(height: SSizes.spaceBtwItems / 2),
                    /// Brand
                    SShimmerEffect(width: 110, height: 15)
                  ],

                ),

                Row(
                  children: [
                    SShimmerEffect(width: 40, height: 20),
                    SizedBox(width: SSizes.spaceBtwSections),
                    SShimmerEffect(width: 40, height: 20)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
