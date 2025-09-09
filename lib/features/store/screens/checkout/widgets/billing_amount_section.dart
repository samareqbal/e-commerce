import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class SBillingAmountSection extends StatelessWidget {
  const SBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹343', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹343', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹33', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹3343', style: Theme.of(context).textTheme.titleMedium),
          ],
        )
      ],
    );
  }
}