import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/authentication/controllers/signup/signup_controller.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/texts.dart';

class SPrivacyPolicyCheckbox extends StatelessWidget {
  const SPrivacyPolicyCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
      children: [
        Obx(() =>  Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.toggle())),
        RichText(text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                  text: '${STexts.iAgreeTo} '
              ),
              TextSpan(
                  text: '${STexts.privacyPolicy}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: dark ? SColors.white : SColors.primary , decoration: TextDecoration.underline, decorationColor: dark ? SColors.white : SColors.primary)
              ),
              TextSpan(
                  text: ' ${STexts.and} '
              ),
              TextSpan(
                  text: '${STexts.termsOfUse} ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: dark ? SColors.white : SColors.primary , decoration: TextDecoration.underline,decorationColor: dark ? SColors.white : SColors.primary)
              ),
            ]
        ))
      ],
    );
  }
}