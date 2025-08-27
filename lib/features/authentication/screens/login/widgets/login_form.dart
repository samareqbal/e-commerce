import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/authentication/screens/forget_password/forget_password.dart';
import 'package:upstore/features/authentication/screens/signup/signup.dart';
import 'package:upstore/navigation_menu.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //Email
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: STexts.email
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

        const SizedBox(height: SSizes.spaceBtwInputFields / 2),

        //Remember me and forgot password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(value: true, onChanged: (value){}),
                const Text(STexts.rememberMe)
              ],
            ),

            TextButton(onPressed: () => Get.to(() => ForgetPasswordScreen()), child: const Text(STexts.forgetPassword))
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwSections),
        //Signin

        SElevatedButton(onPressed: () => Get.to(() => NavigationMenu()), child: const Text(STexts.signIn)),
        const SizedBox(height: SSizes.spaceBtwItems/2),
        SizedBox(
          width: double.infinity,
            child: OutlinedButton(onPressed: () =>  Get.to(() => const SignupScreen()), child: const Text(STexts.createAccount)))
      ],
    );
  }
}