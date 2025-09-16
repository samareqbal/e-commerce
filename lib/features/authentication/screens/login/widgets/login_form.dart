import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/authentication/controllers/login/login_controller.dart';
import 'package:upstore/features/authentication/screens/forget_password/forget_password.dart';
import 'package:upstore/features/authentication/screens/signup/signup.dart';
import 'package:upstore/utils/validators/validation.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Email
          TextFormField(
            controller: controller.email,
            validator: (value) => SValidator.validateEmail(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: STexts.email
            ),
          ),

          const SizedBox(height: SSizes.spaceBtwInputFields),

          //Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: controller.isPasswordVisible.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => SValidator.validateEmptyText('Password', value),
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: STexts.password,
                  suffixIcon: IconButton(
                      onPressed: () => controller.isPasswordVisible.toggle(),
                      icon: Icon(controller.isPasswordVisible.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye))
              ),
            ),
          ),

          const SizedBox(height: SSizes.spaceBtwInputFields / 2),

          //Remember me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.toggle())),
                  const Text(STexts.rememberMe)
                ],
              ),

              TextButton(onPressed: () => Get.to(() => ForgetPasswordScreen()), child: const Text(STexts.forgetPassword))
            ],
          ),

          const SizedBox(height: SSizes.spaceBtwSections),
          //Signin

          SElevatedButton(onPressed: () => controller.loginWithEmailAndPassword(), child: const Text(STexts.signIn)),
          const SizedBox(height: SSizes.spaceBtwItems/2),
          SizedBox(
            width: double.infinity,
              child: OutlinedButton(onPressed: () =>  Get.to(() => const SignupScreen()), child: const Text(STexts.createAccount)))
        ],
      ),
    );
  }
}