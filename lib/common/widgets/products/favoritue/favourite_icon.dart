import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/store/controllers/product/favourite_controller.dart';

import '../../icons/circular_icon.dart';

class SFavouriteIcon extends StatelessWidget {
  const SFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(
       () => SCircularIcon(
        icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(productId) ? Colors.red: null,
        onPressed: () => controller.toggleFavourite(productId),
      ),
    );
  }
}
