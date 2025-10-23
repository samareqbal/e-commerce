import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/controllers/promo_code/promo_code_controller.dart';
import 'package:upstore/utils/constants/colors.dart';
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
    final promoCodeController = PromoCodeController.instance;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('${STexts.currency}$subTotal',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '${STexts.currency}${SPricingCalculator.calculateShippingCost(subTotal, "India")}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '${STexts.currency}${SPricingCalculator.calculateTax(subTotal, "India")}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text('Order Total', style: Theme.of(context).textTheme.bodyMedium)),
            Obx(() {
              double total =
                  SPricingCalculator.calculateTotalPrice(subTotal, "India");
              final promoCode = promoCodeController.appliedPromoCode.value;
              total = promoCodeController.calculatePriceAfterDiscount(
                  promoCode, total);

              return Text('${STexts.currency}${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium);
            }),
          ],
        ),

        const SizedBox(height: SSizes.spaceBtwItems / 2),

        Obx((){
          final promoCode = promoCodeController.appliedPromoCode.value;

          if(promoCode.id.isEmpty){
            return const SizedBox.shrink();
          }

          return Row(
            children: [
              Expanded(child: Text('Discount', style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.success))),

              Text(promoCodeController.getDiscountPrice() , style: Theme.of(context).textTheme.titleMedium!.apply(color: SColors.success))
            ],
          );
        })
      ],
    );
  }
}
