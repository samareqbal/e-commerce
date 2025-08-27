import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/button/social_buttons.dart';
import 'package:upstore/common/widgets/login_signup/form_divider.dart';
import 'package:upstore/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../utils/constants/texts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              Text(STexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),

              const SizedBox(height: SSizes.spaceBtwSections),

              //Forms
              const SSignupForm(),

              const SizedBox(height: SSizes.spaceBtwSections),

              //Divider
              const SFormDivider(title: STexts.orSignupWith),

              const SizedBox(height: SSizes.spaceBtwSections),

              //Footer
              const SSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
