import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/constants/texts.dart';

import '../../../../utils/validators/validation.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
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
                  Form(
                    key: controller.forgetPasswordFormKey,
                    child: TextFormField(
                      controller: controller.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => SValidator.validateEmail(value),
                      decoration: const InputDecoration(
                        labelText: STexts.email,
                        prefixIcon: Icon(Iconsax.direct_right)
                      ),
                    ),
                  ),

                  const SizedBox(height: SSizes.spaceBtwItems),

                  SElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(STexts.submit))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
