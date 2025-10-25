import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/shimmer/address_shimmer.dart';
import 'package:upstore/features/personalization/controllers/address_controller.dart';
import 'package:upstore/features/personalization/screens/address/add_new_address.dart';
import 'package:upstore/features/personalization/screens/address/widgets/single_address.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text("Addresses",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
            child: Obx(
              () => FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllAddress(),
                builder: (context, snapshot) {
                  const loader = SAddressShimmer();
                  final widget = SCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final addresses = snapshot.data!;

                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SSingleAddress(
                          onTap: () =>
                              controller.selectAddress(addresses[index]),
                          address: addresses[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: SSizes.spaceBtwItems),
                      itemCount: addresses.length);
                },
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: SColors.primary,
        child: const Icon(Iconsax.add, color: SColors.white),
      ),
    );
  }
}
