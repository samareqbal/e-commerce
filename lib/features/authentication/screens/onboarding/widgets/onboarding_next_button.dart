import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:upstore/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';

class OnBoardingNextButton extends StatelessWidget {
  OnBoardingNextButton({
    super.key,
  });

  final controller = OnBoardingController.instance;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: SSizes.spaceBtwItems,
        child: SElevatedButton(
          onPressed: controller.nextPage,
          child:
              Obx(() => Text(controller.currentIndex.value == 2 ? "Get Started" : "Next")),
        ));
  }
}
