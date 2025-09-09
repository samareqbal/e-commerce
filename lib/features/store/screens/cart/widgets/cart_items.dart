import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/products/cart/product_quantity_with_add_remove.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key, this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) =>
      const SizedBox(height: SSizes.spaceBtwSections),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SCartItem(),
            if(showAddRemoveButtons) const SizedBox(width: SSizes.spaceBtwItems),
            if(showAddRemoveButtons) Row(
              children: [
                const SizedBox(width: 70),
                SProductQuantityWithAddRemove(),
                Spacer(),
                SProductPriceText(price: '7000')
              ],
            )
          ],
        );
      },
    );
  }
}