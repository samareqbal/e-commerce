import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/personalization/controllers/change_name_controller.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/validators/validation.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/texts.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text("Update Name",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update your name to keep your profile accurate and personalized",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: SSizes.spaceBtwSections),
              Form(
                key: controller.updateUserFormKey,
                  child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        SValidator.validateEmptyText('First Name', value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        labelText: STexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),

                  const SizedBox(height: SSizes.spaceBtwInputFields),

                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        SValidator.validateEmptyText('Last Name', value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        labelText: STexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),

                  const SizedBox(height: SSizes.spaceBtwSections),

                  SElevatedButton(onPressed: () => controller.updateUserName(), child: Text("Save"))

                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
