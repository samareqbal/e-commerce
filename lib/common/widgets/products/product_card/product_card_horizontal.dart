import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/button/add_to_cart_button.dart';
import 'package:upstore/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:upstore/common/widgets/texts/product_price_text.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../features/store/controllers/product/product_controller.dart';
import '../../../../features/store/screens/product_details/product_details.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../favoritue/favourite_icon.dart';

class SProductCardHorizontal extends StatelessWidget {
  const SProductCardHorizontal({
    super.key, required this.product,

  });

  final ProductModel product;



  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final productController = ProductController.instance;
    String? salePercentage = productController.calculateSalePercentage(
        product.price, product.salePrice);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(SSizes.productImageRadius),
            color: dark ? SColors.darkerGrey : SColors.grey),
        child: Row(
          children: [
            SRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(SSizes.sm),
              backgroundColor: dark ? SColors.dark : SColors.light,
              child: Stack(
                children: [
                  SizedBox(
                      width:120,
                      height: 120,
                      child: SRoundedImage(
                          imageUrl: product.thumbnail, isNetworkImage: true)),

                  if(salePercentage != null)
                  Positioned(
                    top: 12.0,
                    child: SRoundedContainer(
                      radius: SSizes.sm,
                      backgroundColor: SColors.yellow.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: SSizes.sm, vertical: SSizes.xs),
                      child: Text(salePercentage,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: SColors.black)),
                    ),
                  ),

                  //Favourite button
                  Positioned(
                      right: 0,
                      top: 0,
                      child: SFavouriteIcon(productId: product.id))
                ],
              ),
            ),
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(left: SSizes.sm,top: SSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SProductTitleText(title: product.title,smallSize: true),
                        SizedBox(height: SSizes.spaceBtwItems/2),
                        SBrandTitleWithVerifyIcon(title: product.brand!.name)
                      ],
                    ),

                    Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: SProductPriceText(price: productController.getProductPrice(product))),
                        SAddToCartButton(product: product)
                      ],
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}