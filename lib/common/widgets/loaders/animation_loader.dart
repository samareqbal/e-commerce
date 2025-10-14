
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';

class SAnimationLoader extends StatelessWidget {
  const SAnimationLoader(
      {super.key,
      required this.text,
      this.animation = SImages.loadingAnimation,
      this.showActionButton = false,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showActionButton;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Animation
          Lottie.asset(animation, width: Get.width * 0.8),
          const SizedBox(height: SSizes.defaultSpace),

          /// Title
          Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: SSizes.defaultSpace),

          showActionButton ?
          SizedBox(
              width : 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(backgroundColor: SColors.dark),
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.light),
                ),
              )
          ) : const SizedBox()
        ],
      ),
    );
  }
}
