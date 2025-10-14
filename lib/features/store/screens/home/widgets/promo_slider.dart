import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';
import 'package:upstore/features/store/controllers/banner/banner_controller.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';
import 'banner_dot_navigation.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());

    return Obx(() {
      if (bannerController.isLoading.value) {
        return const SShimmerEffect(width: double.infinity, height: 190);
      }

      if (bannerController.banners.isEmpty) {
        return const Text('Banners not found');
      }

      return Column(
        children: [
          CarouselSlider(
            items: bannerController.banners
                .map((banner) => SRoundedImage(
                    imageUrl: banner.imageUrl, isNetworkImage: true, onTap: () => Get.toNamed(banner.targetScreen),))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, reason) =>
                  bannerController.onPageChanged(index),
            ),
            carouselController: bannerController.carouselController,
          ),
          const SizedBox(height: SSizes.spaceBtwItems),
          BannerDotNavigation()
        ],
      );
    });
  }
}
