import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/personalization/controllers/address_controller.dart';
import 'package:upstore/features/personalization/models/address_model.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';

class SSingleAddress extends StatelessWidget {
  const SSingleAddress({
    super.key,
    required this.address, required this.onTap,
  });


  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;
    return Obx((){
      final selectedAddressId = controller.selectedAddress.value.id;
      bool isSelected = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: SRoundedContainer(
            width: double.infinity,
            showBorder: true,
            padding: const EdgeInsets.all(SSizes.md),
            backgroundColor: isSelected
                ? SColors.primary.withValues(alpha: 0.4)
                : Colors.transparent,
            borderColor: isSelected ? Colors.transparent : dark ? SColors.darkerGrey : SColors.grey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: SSizes.spaceBtwItems/2),
                    Text(address.phoneNumber,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: SSizes.spaceBtwItems/2),
                    Text(address.toString()),
                  ],
                ),
                if(isSelected) const Positioned(
                    top: 0,
                    bottom: 0,
                    right: 6,
                    child: Icon(Iconsax.tick_circle5))
              ],
            )),
      );
    });
  }
}
