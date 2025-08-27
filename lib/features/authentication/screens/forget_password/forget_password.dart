import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/authentication/screens/forget_password/reset_password.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/constants/texts.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Header
              Text(STexts.forgetPasswordTitle , style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              Text(STexts.forgetPasswordSubTitle),


              const SizedBox(height: SSizes.spaceBtwSections * 2),

              //Form
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: STexts.email,
                      prefixIcon: Icon(Iconsax.direct_right)
                    ),
                  ),

                  const SizedBox(height: SSizes.spaceBtwItems),

                  SElevatedButton(onPressed: () => Get.to(() => ResetPasswordScreen()), child: const Text(STexts.submit))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
