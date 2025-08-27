import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/authentication/screens/signup/verify_email.dart';
import 'package:upstore/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //First and Last Name
        Row(
          children: [
            Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: STexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                )),
            SizedBox(width: SSizes.spaceBtwInputFields),
            Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: STexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                )),
          ],
        ) ,

        SizedBox(height: SSizes.spaceBtwItems),

        //Email
        TextFormField(
          decoration: const InputDecoration(
              labelText: STexts.email,
              prefixIcon: Icon(Iconsax.direct_right)
          ),
        ),

        const SizedBox(height: SSizes.spaceBtwItems),

        //Phone Number
        TextFormField(
          decoration: const InputDecoration(
              labelText: STexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call)
          ),
        ),

        const SizedBox(height: SSizes.spaceBtwInputFields),

        //Password
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: STexts.password,
              suffixIcon: Icon(Iconsax.eye)
          ),
        ),

        const SizedBox(height: SSizes.spaceBtwInputFields/2),

        //Terms and condition with checkbox
        SPrivacyPolicyCheckbox(),

        const SizedBox(height: SSizes.spaceBtwSections),

        SElevatedButton(onPressed: () => Get.to(() => VerifyEmailScreen()), child: const Text(STexts.createAccount)),
      ],
    );
  }
}

