import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/texts/product_price_text.dart';
import 'package:upstore/common/widgets/texts/product_title_text.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chips.dart';

class SProductAttributes extends StatelessWidget {
  const SProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        SRoundedContainer(
          padding: EdgeInsets.all(SSizes.md),
          backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: SSizes.spaceBtwItems),
                  Column(
                    children: [
                      Row(
                        children: [
                          SProductTitleText(
                              title: 'Price: ', smallSize: true),
                          Text('250',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration:
                                          TextDecoration.lineThrough)),
                          const SizedBox(width: SSizes.spaceBtwItems),
                          SProductPriceText(
                            price: '200',
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SProductTitleText(
                              title: 'Stock: ', smallSize: true),
                          Text('In Stock',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              //Attribute description
              SProductTitleText(
                  title: 'This is a product of iPhone 11 with 512 GB',
                  smallSize: true,
                  maxLines: 4)
            ],
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwItems),

        //Attributes - Colors
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SSectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(height: SSizes.spaceBtwItems/2),
            Wrap(
              spacing: SSizes.sm,
              children: [
                SChoiceChip(text: 'Red', selected: false, onSelected: (value) {}),
                SChoiceChip(text: 'Blue', selected: true, onSelected: (value) {}),
                SChoiceChip(text: 'Yellow', selected: false, onSelected: (value) {})
              ],
            )
          ],
        ),

        //Attributes - Sizes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SSectionHeading(title: 'Sizes', showActionButton: false),
            const SizedBox(height: SSizes.spaceBtwItems/2),
            Wrap(
              spacing: SSizes.sm,
              children: [
                SChoiceChip(text: 'Small', selected: false, onSelected: (value) {}),
                SChoiceChip(text: 'Medium', selected: true, onSelected: (value) {}),
                SChoiceChip(text: 'Large', selected: false, onSelected: (value) {})
              ],
            )
          ],
        ),


      ],
    );
  }
}
