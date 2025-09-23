import 'package:flutter/material.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SSizes.defaultSpace),
          child: Column(
            children: [
              SBrandShowCase(
                images: [
                  SImages.productImage47,
                  SImages.productImage43,
                  SImages.productImage41
                ],
              ),
              SBrandShowCase(
                images: [
                  SImages.productImage47,
                  SImages.productImage43,
                  SImages.productImage41
                ],
              ),

              const SizedBox(height: SSizes.spaceBtwItems),

              SSectionHeading(title: 'You might like', onPressed: (){}),

              SGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SProductCardVertical(product: ProductModel.empty());
                },
              ),

              const SizedBox(height: SSizes.spaceBtwSections)
            ],
          ),
        )
      ],
    );
  }
}