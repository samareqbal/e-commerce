import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/features/store/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:upstore/features/store/screens/product_details/widgets/product_attributes.dart';
import 'package:upstore/features/store/screens/product_details/widgets/product_meta_data.dart';
import 'package:upstore/features/store/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:upstore/utils/constants/enums.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../common/widgets/button/elevated_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [
            SProductThumbnailAndSlider(product: product),

            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  SProductMetaData(product: product),
                  const SizedBox(height: SSizes.spaceBtwSections),

                  if(product.productType == ProductType.variable.toString())...[
                    SProductAttributes(product: product),
                    const SizedBox(height: SSizes.spaceBtwSections),
                  ],

                  SElevatedButton(onPressed: (){}, child: Text('Checkout')),
                  const SizedBox(height: SSizes.spaceBtwSections),
                  SSectionHeading(title: 'Description',showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' show more',
                    trimExpandedText: ' show less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SBottomAddToCart(product: product,),
    );
  }
}


