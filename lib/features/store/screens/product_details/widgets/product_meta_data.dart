import 'package:flutter/material.dart';

import '../../../../../common/style/padding.dart';
import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';

class SProductMetaData extends StatelessWidget {
  const SProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SPadding.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SRoundedContainer(
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
              const SizedBox(width: SSizes.spaceBtwItems),
              Text('₹300',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(decoration: TextDecoration.lineThrough)),
              const SizedBox(width: SSizes.spaceBtwItems),
              SProductPriceText(price: "150", isLarge: true, currencySign: '₹'),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.share))
            ],
          ),
          const SizedBox(height: SSizes.spaceBtwItems / 1.5),
          SProductTitleText(title: 'Apple iPhone 11'),
          const SizedBox(height: SSizes.spaceBtwItems / 1.5),
          Row(
            children: [
              SProductTitleText(title: 'Status'),
              const SizedBox(width: SSizes.spaceBtwItems),
              Text('In stock', style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
          const SizedBox(height: SSizes.spaceBtwItems / 1.5),
          Row(
            children: [
              SCircularImage(
                  image: SImages.adidasLogo,
                  width: 32.0,
                  height: 32.0,
                  padding: 0),
              const SizedBox(width: SSizes.spaceBtwItems),
              SBrandTitleWithVerifyIcon(title: 'Adidas')
            ],
          ),
        ],
      ),
    );
  }
}
