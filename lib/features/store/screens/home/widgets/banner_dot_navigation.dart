import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/home/home_controller.dart';

class BannerDotNavigation extends StatelessWidget {
  BannerDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Obx(
      () =>  SmoothPageIndicator(
        count: 6,
        effect: const ExpandingDotsEffect(dotHeight: 6.0),
        controller: PageController(
          initialPage: controller.currentIndex.value
        ),
      ),
    );
  }
}