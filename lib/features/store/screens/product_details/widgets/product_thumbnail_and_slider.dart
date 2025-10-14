import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/product/image_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/products/favoritue/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SProductThumbnailAndSlider extends StatelessWidget {
  const SProductThumbnailAndSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    List<String> images = controller.getAllProductImages(product);

    return Container(
      color: dark ? SColors.darkerGrey : SColors.light,
      child: Stack(
        children: [
          //Thumbnail
          SizedBox(
              height: 400,
              child: Padding(
                  padding: EdgeInsets.all(SSizes.productImageRadius * 2),
                  child: Center(
                      child: Obx(
                        () {

                          final image = controller.selectedProductImage.value;

                          return GestureDetector(
                            onTap: () => controller.showEnlargedImage(image),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              progressIndicatorBuilder: (context, url, progress) =>
                                  CircularProgressIndicator(
                                      color: SColors.primary, value: progress.progress),
                            ),
                          );
                        }
                      )))),

          Positioned(
            left: SSizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: SSizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) => Obx(
                    () {

                      bool isImageSelected = controller.selectedProductImage.value == images[index];


                      return SRoundedImage(
                          width: 80,
                          isNetworkImage: true,
                          onTap: () => controller.selectedProductImage.value = images[index],
                          backgroundColor: dark ? SColors.dark : SColors.white,
                          padding: EdgeInsets.all(SSizes.sm),
                          border: Border.all(color: isImageSelected ? SColors.primary : Colors.transparent),
                          imageUrl: images[index]);
                    }
                ),
              ),
            ),
          ),

          SAppBar(
            showBackArrow: true,
            actions: [
              SFavouriteIcon(productId: product.id,)
            ],
          )
        ],
      ),
    );
  }
}
