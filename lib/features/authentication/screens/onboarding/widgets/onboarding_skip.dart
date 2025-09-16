import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/device_helpers.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingSkipButton extends StatelessWidget {
 OnBoardingSkipButton({
    super.key,
  });

  //final controller = OnBoardingController.instance;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardingController>();
    return Obx(
        () =>  controller.currentIndex == 2 ? const SizedBox() : Positioned(
          top: SDeviceHelper.getAppBarHeight(),
          right: 0,
          child: TextButton(
            onPressed: controller.skipPage,
            child: const Text('Skip'),
          )
      ),
    );
  }
}