import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/features/personalization/controllers/address_controller.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text("Add New Address",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => SValidator.validateEmptyText('Name', value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name'
                  ),
                ),

                const SizedBox(height: SSizes.spaceBtwInputFields),

                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => SValidator.validateEmptyText('Phone Number', value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Phone Number'
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => SValidator.validateEmptyText('Street', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: 'Street'
                        ),
                      ),
                    ),
                    const SizedBox(width: SSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => SValidator.validateEmptyText('Postal Code', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: 'Postal Code'
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => SValidator.validateEmptyText('City', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City'
                        ),
                      ),
                    ),
                    const SizedBox(width: SSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) => SValidator.validateEmptyText('State', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: 'State'
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                  validator: (value) => SValidator.validateEmptyText('Country', value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.global),
                      labelText: 'Country'
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwSections),
                SElevatedButton(onPressed: () => controller.addNewAddress(), child: Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
