import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';

import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/products/cart/product_quantity_with_add_remove.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) =>
            const SizedBox(height: SSizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];
          return Column(
            children: [
              SCartItem(cartItem: cartItem),
              if (showAddRemoveButtons)
                const SizedBox(width: SSizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  children: [
                    const SizedBox(width: 70),
                    SProductQuantityWithAddRemove(
                      quantity: cartItem.quantity,
                      add: () => controller.addOneToCart(cartItem),
                      remove: () => controller.removeOneFromCart(cartItem),
                    ),
                    Spacer(),
                    SProductPriceText(
                        price: (cartItem.price * cartItem.quantity)
                            .toStringAsFixed(0))
                  ],
                )
            ],
          );
        },
      ),
    );
  }
}
