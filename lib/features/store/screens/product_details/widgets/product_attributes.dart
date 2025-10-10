import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/texts/product_price_text.dart';
import 'package:upstore/common/widgets/texts/product_title_text.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/store/controllers/product/variation_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chips.dart';
import '../../../../../utils/constants/texts.dart';

class SProductAttributes extends StatelessWidget {
  const SProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
        () => Column(
        children: [

          if(controller.selectedVariations.value.id.isNotEmpty)
          SRoundedContainer(
            padding: const EdgeInsets.all(SSizes.md),
            backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SSectionHeading(title: 'Variation', showActionButton: false),
                    const SizedBox(width: SSizes.spaceBtwItems),
                    Column(
                      children: [
                        Row(
                          children: [
                            const SProductTitleText(title: 'Price: ', smallSize: true),

                            if(controller.selectedVariations.value.salePrice > 0)
                            Text('${STexts.currency}${controller.selectedVariations.value.price.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough)),
                            const SizedBox(width: SSizes.spaceBtwItems),
                            SProductPriceText(
                              price: controller.getVariationPrice(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const SProductTitleText(title: 'Stock: ', smallSize: true),
                            Text(controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        )
                      ],
                    ),
                  ],
                ),

                //Attribute description
                SProductTitleText(
                    title: controller.selectedVariations.value.description ?? '',
                    smallSize: true,
                    maxLines: 4)
              ],
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwItems),

          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.productAttributes!.map((attribute) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SSectionHeading(title: attribute.name ?? '', showActionButton: false,),
                    const SizedBox(
                      height: SSizes.spaceBtwItems / 2,
                    ),
                    Obx(
                          () => Wrap(
                          spacing: 8,
                          children: attribute.values!
                              .map(
                                  (attributeValue) {
                                final isSelected = controller.selectedAttributes[attribute.name] == attributeValue; // 'Green' == 'Green'
                                final available = controller.getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!)
                                    .contains(attributeValue);
                                return SChoiceChip(
                                  text: attributeValue,
                                  selected: isSelected,
                                  onSelected: available ? (selected){
                                    if(available && selected){
                                      controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                                    }
                                  } : null,
                                );
                              }
                          )
                              .toList()),
                    )
                  ],
                );
              }).toList())

          //Attributes - Colors
          // Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: product.productAttributes!.map((attribute) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SSectionHeading(
          //               title: attribute.name ?? '', showActionButton: false),
          //           const SizedBox(height: SSizes.spaceBtwItems / 2),
          //           Obx(
          //       () => Wrap(
          //                 spacing: SSizes.sm,
          //                 children: attribute.values!.map((values) {
          //                   bool isSelected =
          //                       controller.selectedAttributes[attribute.name] ==
          //                           values;
          //                   bool available = controller
          //                       .getAttributesAvailabilityInVariation(
          //                           product.productVariations!, attribute.name!)
          //                       .contains(values);
          //                   return SChoiceChip(
          //                       text: values,
          //                       selected: isSelected,
          //                       onSelected: available ? (value) {
          //                         if(available && isSelected){
          //                           controller.onAttributeSelected(product, attribute.name, values);
          //                         }
          //                       } : null
          //                   );
          //                 }).toList()),
          //           )
          //         ],
          //       );
          //     }).toList()),
        ],
      ),
    );
  }
}
