import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/button/elevated_button.dart';
import 'package:upstore/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text("Add New Address",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Name'
                ),
              ),

              const SizedBox(height: SSizes.spaceBtwInputFields),

              TextFormField(
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
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street'
                      ),
                    ),
                  ),
                  const SizedBox(width: SSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
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
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City'
                      ),
                    ),
                  ),
                  const SizedBox(width: SSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
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
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country'
                ),
              ),
              const SizedBox(height: SSizes.spaceBtwSections),
              SElevatedButton(onPressed: (){}, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
