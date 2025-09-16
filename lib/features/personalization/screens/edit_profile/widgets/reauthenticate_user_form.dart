import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/constants/texts.dart';
import 'package:upstore/utils/validators/validation.dart';

class ReAuthenticateUserForm extends StatelessWidget {
  const ReAuthenticateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Re-Authenticate User', style: Theme.of(context).textTheme.headlineMedium),
      ),

      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Form(
            key: controller.reAuthenticateFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    validator: (value) => SValidator.validateEmail(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: STexts.email
                    ),
                  ),

                  const SizedBox(height: SSizes.spaceBtwInputFields),

                  Obx(
                      () => TextFormField(
                        controller: controller.password,
                      obscureText: controller.isPasswordVisible.value,
                      validator: (value) => SValidator.validateEmptyText('Password',value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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

                  const SizedBox(height: SSizes.spaceBtwSections),

                  SElevatedButton(onPressed: () => controller.reAuthenticateUser(), child: Text('Verify'))
                ],
              )
          ),
        ),
      ),
    );
  }
}
