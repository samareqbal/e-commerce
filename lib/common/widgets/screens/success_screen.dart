import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/device_helpers.dart';
import '../button/elevated_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.title, required this.subTitle, required this.image, required this.onTap});

  final String title, subTitle, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              Image.asset(image,height: SDeviceHelper.getScreenHeight(context) * 0.4),

              const SizedBox(height: SSizes.spaceBtwItems),
              Text(title, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwItems),
              Text(subTitle,style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwSections),


              //Button
              SElevatedButton(onPressed: onTap, child: const Text(STexts.uContinue)),
            ],
          ),
        ),
      ),
    );
  }
}
