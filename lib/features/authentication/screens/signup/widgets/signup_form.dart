import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/authentication/controllers/signup/signup_controller.dart';
import 'package:upstore/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:upstore/utils/validators/validation.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          //First and Last Name
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.firstName,
                    textCapitalization: TextCapitalization.words,
                validator: (value) =>
                    SValidator.validateEmptyText('First Name', value),
                decoration: InputDecoration(
                    labelText: STexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              )),
              SizedBox(width: SSizes.spaceBtwInputFields),
              Expanded(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.lastName,
                    textCapitalization: TextCapitalization.words,
                validator: (value) =>
                    SValidator.validateEmptyText('Last Name', value),
                decoration: InputDecoration(
                    labelText: STexts.lastName, prefixIcon: Icon(Iconsax.user)),
              )),
            ],
          ),

          SizedBox(height: SSizes.spaceBtwItems),

          //Email
          TextFormField(
            controller: controller.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => SValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: STexts.email,
                prefixIcon: Icon(Iconsax.direct_right)),
          ),

          const SizedBox(height: SSizes.spaceBtwItems),

          //Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(10)],
            validator: (value) => SValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: STexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),

          const SizedBox(height: SSizes.spaceBtwInputFields),

          //Password
          Obx(
            () => TextFormField(
              obscureText: controller.isPasswordVisible.value,
              controller: controller.password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => SValidator.validatePassword(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: STexts.password,
                  suffixIcon: IconButton(
                      onPressed: () => controller.isPasswordVisible.toggle(),
                      icon: Icon(controller.isPasswordVisible.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye))),
            ),
          ),

          const SizedBox(height: SSizes.spaceBtwInputFields / 2),

          //Terms and condition with checkbox
          SPrivacyPolicyCheckbox(),

          const SizedBox(height: SSizes.spaceBtwSections),

          SElevatedButton(
              onPressed: () => controller.registerUser(),
              child: const Text(STexts.createAccount)),
        ],
      ),
    );
  }
}
