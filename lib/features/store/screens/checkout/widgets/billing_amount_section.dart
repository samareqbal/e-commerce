import 'package:flutter/material.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/utils/constants/texts.dart';
import 'package:upstore/utils/helpers/pricing_calculator.dart';

import '../../../../../utils/constants/sizes.dart';

class SBillingAmountSection extends StatelessWidget {
  const SBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('${STexts.currency}$subTotal', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('${STexts.currency}${SPricingCalculator.calculateShippingCost(subTotal, "India")}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('${STexts.currency}${SPricingCalculator.calculateTax(subTotal, "India")}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems/2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('${STexts.currency}${SPricingCalculator.calculateTotalPrice(subTotal, "India")}', style: Theme.of(context).textTheme.titleMedium),
          ],
        )
      ],
    );
  }
}