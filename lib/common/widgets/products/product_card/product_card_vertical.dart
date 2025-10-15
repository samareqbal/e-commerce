import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/button/add_to_cart_button.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/images/rounded_image.dart';
import 'package:upstore/features/store/controllers/product/product_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/features/store/screens/product_details/product_details.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../style/shadow.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../favoritue/favourite_icon.dart';

class SProductCardVertical extends StatelessWidget {
  const SProductCardVertical({
    super.key,
    required this.product,
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
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: SShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(SSizes.productImageRadius),
          color: dark ? SColors.darkerGrey : SColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Thumbnail , Favorite button , discount tag
            SRoundedContainer(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.all(SSizes.sm),
              backgroundColor: dark ? SColors.dark : SColors.light,
              child: Stack(
                children: [
                  //Thumbnail
                  Center(
                      child: SRoundedImage(
                          imageUrl: product.thumbnail,
                          // /applyImageRadius: true,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          isNetworkImage: true)),

                  if (salePercentage != null)
                    //Discount tag
                    Positioned(
                      top: 12.0,
                      child: SRoundedContainer(
                        radius: SSizes.sm,
                        backgroundColor: SColors.yellow.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: SSizes.sm, vertical: SSizes.xs),
                        child: Text("$salePercentage%",
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
                      child: SFavouriteIcon(productId: product.id,))
                ],
              ),
            ),

            const SizedBox(height: SSizes.spaceBtwItems / 2),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: SSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SProductTitleText(title: product.title, smallSize: true),
                    const SizedBox(height: SSizes.spaceBtwItems / 2),
                    SBrandTitleWithVerifyIcon(title: product.brand!.name),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: SSizes.sm),
                  child: SProductPriceText(
                    //currencySign: '₹',
                    price: productController.getProductPrice(product),
                  ),
                ),
                SAddToCartButton(product: product)
              ],
            )
          ],
        ),
      ),
    );
  }
}
