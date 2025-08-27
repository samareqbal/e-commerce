import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:upstore/features/store/controllers/home/home_controller.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';
import 'banner_dot_navigation.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({
    super.key, required this.banners,
  });
  
  final List<String> banners;

  @override
  Widget build(BuildContext context) {

    final controller = HomeController.instance;

    return Column(
      children: [
        CarouselSlider(
            items: banners.map((banner) => SRoundedImage(imageUrl: banner)).toList(),
            options: CarouselOptions(viewportFraction: 1.0, onPageChanged: (index, reason) => controller.onPageChanged(index),),
          carouselController: controller.carouselController,
        ),

        const SizedBox(height: SSizes.spaceBtwItems),

        BannerDotNavigation()
      ],
    );
  }
}