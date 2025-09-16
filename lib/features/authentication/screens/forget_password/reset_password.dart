import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:upstore/features/authentication/screens/login/login.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/helpers/device_helpers.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => LoginScreen()), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              Image.asset(SImages.mailSentImage,height: SDeviceHelper.getScreenHeight(context) * 0.4),


              //Title
              Text(STexts.resetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SSizes.spaceBtwItems ),
              Text(email, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: SSizes.spaceBtwItems),
              Text(STexts.resetPasswordSubTitle,style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center),

              const SizedBox(height: SSizes.spaceBtwSections),


              //Button
              SElevatedButton(onPressed: () => Get.offAll(() => LoginScreen()), child: const Text(STexts.done)),
              const SizedBox(height: SSizes.spaceBtwItems / 2),

              //Resend Email
              SizedBox(
                width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.resendPasswordResetEmail(),
                      child: const Text(
                          STexts.resendEmail
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
