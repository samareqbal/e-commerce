import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/authentication/controllers/login/login_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';

class SSocialButtons extends StatelessWidget {
  const SSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(SImages.googleIcon,controller.googleSignIn),

        const SizedBox(width: SSizes.spaceBtwItems),


        buildButton(SImages.facebookIcon,(){}),
      ],
    );
  }

  Container buildButton(String image, VoidCallback onPressed) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: SColors.grey),
            borderRadius: BorderRadius.circular(100)
        ),
        child: IconButton(onPressed: onPressed, icon: Image.asset(image,height: SSizes.iconMd, width: SSizes.iconMd ,),),
      );
  }
}