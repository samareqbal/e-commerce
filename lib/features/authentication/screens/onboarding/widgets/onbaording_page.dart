import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/device_helpers.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.animation, required this.title, required this.subTitle,
  });

  final String animation;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SDeviceHelper.getAppBarHeight()),
      child: Column(
        children: [
          //Animation
          Lottie.asset(animation),

          //Title
          Text(title, style: Theme.of(context).textTheme.headlineMedium,),

          //Subtitle
          Text(subTitle, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineSmall,),

          // Image(
          //     height: SDeviceHelper.getScreenHeight(context) * 0.6,
          //     width: SDeviceHelper.getScreenWidth(context) * 0.8,
          //     image: AssetImage(animation)),
          // Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
          // const SizedBox(height: SSizes.spaceBtwItems,),
          // Text(subTitle, style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}