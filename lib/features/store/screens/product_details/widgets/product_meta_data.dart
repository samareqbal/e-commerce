import 'package:flutter/material.dart';
import 'package:upstore/features/store/controllers/product/product_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/constants/texts.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SProductMetaData extends StatelessWidget {
  const SProductMetaData({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [

            if(salePercentage != null)...[
              SRoundedContainer(
                radius: SSizes.sm,
                backgroundColor: SColors.yellow.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: SSizes.sm, vertical: SSizes.xs),
                child: Text("${salePercentage}%",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: SColors.black)),
              ),
              const SizedBox(width: SSizes.spaceBtwItems),
            ],


            if(product.productType == ProductType.single.toString() && product.salePrice > 0)...[
              Text('${STexts.currency}${product.price.toStringAsFixed(0)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(decoration: TextDecoration.lineThrough)),
              const SizedBox(width: SSizes.spaceBtwItems),
            ],

            SProductPriceText(price: controller.getProductPrice(product), isLarge: true),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.share))
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),
        SProductTitleText(title: product.title),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            SProductTitleText(title: 'Status'),
            const SizedBox(width: SSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            SCircularImage(
              isNetworkImage: true,
                image: product.brand != null ? product.brand!.image : '',
                width: 32.0,
                height: 32.0,
                padding: 0),
            const SizedBox(width: SSizes.spaceBtwItems),
            SBrandTitleWithVerifyIcon(title: product.brand != null ? product.brand!.name : '')
          ],
        ),
      ],
    );
  }
}
