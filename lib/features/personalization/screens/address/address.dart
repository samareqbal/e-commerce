import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/features/personalization/screens/address/add_new_address.dart';
import 'package:upstore/features/personalization/screens/address/widgets/single_address.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text("Addresses",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SSingleAddress(isSelected: true),
              const SizedBox(height: SSizes.spaceBtwItems),
              SSingleAddress(isSelected: false),
              const SizedBox(height: SSizes.spaceBtwItems),
              SSingleAddress(isSelected: false),
              const SizedBox(height: SSizes.spaceBtwItems),
              SSingleAddress(isSelected: false),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: SColors.primary,
        child: Icon(Iconsax.add ,color: SColors.white),
      ),
    );
  }
}
