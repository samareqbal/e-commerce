import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upstore/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/helpers/device_helpers.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  OnBoardingDotNavigation({
    super.key,
  });

  final controller = OnBoardingController.instance;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: SDeviceHelper.getBottomNavigationBarHeight() * 4,
        left: SDeviceHelper.getScreenWidth(context) / 3,
        right: SDeviceHelper.getScreenWidth(context) / 3,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: const ExpandingDotsEffect(dotHeight: 6.0),
        ));
  }
}