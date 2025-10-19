import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/models/cart_item_model.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/features/store/screens/product_details/product_details.dart';
import 'package:upstore/utils/constants/enums.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SAddToCartButton extends StatelessWidget {
  const SAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    // final dark = SHelperFunctions.isDarkMode(context);
    return InkWell(onTap: () {
      if (product.productType == ProductType.single.toString()) {
        CartItemModel cartItem = controller.convertToCartItem(product, 1);
        controller.addOneToCart(cartItem);
      } else {
        Get.to(() => ProductDetailsScreen(product: product));
      }
    }, child: Obx(() {
      final productQuantityInCart =
          controller.getProductQuantityInCart(product.id);
      return Container(
          width: SSizes.iconLg ,
          height: SSizes.iconLg ,
          decoration:  BoxDecoration(
              color: productQuantityInCart > 0 ?  SColors.dark : SColors.primary,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(SSizes.productImageRadius),
                  topLeft: Radius.circular(SSizes.cardRadiusMd))),
          child: Center(
            child: productQuantityInCart > 0
                ? Text(
                    productQuantityInCart.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: SColors.white),
                  )
                : const Icon(Iconsax.add, color: SColors.white),
          ));
    }));
  }
}
