import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/personalization/controllers/address_controller.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    controller.getAllAddress();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(title: 'Billing Address', buttonTitle: 'Change', onPressed: () => controller.selectNewAddressBottomSheet(context)),

        Obx((){
          final address = controller.selectedAddress.value;
          if(address.id.isEmpty){
            return const Text('Select Address');
          }



          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( address.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: SSizes.spaceBtwItems/2),

              Row(
                children: [
                  const Icon(Icons.phone, size: SSizes.iconSm, color: SColors.darkerGrey),
                  const SizedBox(width: SSizes.spaceBtwItems),
                  Text(address.phoneNumber)
                ],
              ),

              const SizedBox(height: SSizes.spaceBtwItems/2),

              Row(
                children: [
                  const Icon(Icons.location_history, size: SSizes.iconSm, color: SColors.darkerGrey),
                  const SizedBox(width: SSizes.spaceBtwItems),
                  Expanded(child: Text(address.toString(),softWrap: true))
                ],
              )
            ],
          );
        })
      ],
    );
  }
}
