import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(title: 'Billing Address', buttonTitle: 'Change', onPressed: (){}),

        Text('Samar Eqbal' , style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: SSizes.spaceBtwItems/2),

        Row(
          children: [
            Icon(Icons.phone, size: SSizes.iconSm, color: SColors.darkerGrey),
            const SizedBox(width: SSizes.spaceBtwItems),
            Text('+91 9709280453')
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),

        Row(
          children: [
            Icon(Icons.location_history, size: SSizes.iconSm, color: SColors.darkerGrey),
            const SizedBox(width: SSizes.spaceBtwItems),
            Expanded(child: Text('C1 Building, Hari Ganga Society, Yerwada, Pune',softWrap: true))
          ],
        )
      ],
    );
  }
}
