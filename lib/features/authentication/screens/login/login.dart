import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/features/authentication/screens/login/widgets/login_form.dart';
import 'package:upstore/features/authentication/screens/login/widgets/login_header.dart';

import '../../../../common/widgets/button/social_buttons.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Header
              SLoginHeader(),
        
              SizedBox(height: SSizes.spaceBtwSections),
        
              //Forms
              SLoginForm(),
        
              SizedBox(height: SSizes.spaceBtwSections),
        
              //Divider
              SFormDivider(title: STexts.orSignInWith,),
        
              SizedBox(height: SSizes.spaceBtwSections),
        
              //Footer
              SSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}








