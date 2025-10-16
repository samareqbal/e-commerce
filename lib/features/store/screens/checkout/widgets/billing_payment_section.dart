import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/store/controllers/checkout/checkout_controller.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/images.dart';

class SBillingPaymentSection extends StatelessWidget {
  const SBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        SSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () => controller.selectPaymentMethod(context)),
        const SizedBox(height: SSizes.spaceBtwItems/2),

        Obx(
          () => Row(
            children: [
              SRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? SColors.darkerGrey : SColors.light,
                padding: EdgeInsets.all(SSizes.sm),
                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),
              ),

              const SizedBox(width: SSizes.spaceBtwItems/2),

              Text(controller.selectedPaymentMethod.value.name , style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        )
      ],
    );
  }
}
