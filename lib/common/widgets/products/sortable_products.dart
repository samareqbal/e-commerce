import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:upstore/features/store/controllers/product/all_product_controller.dart';

import '../../../features/store/models/product_model.dart';
import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class SSortableProducts extends StatelessWidget {
  const SSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          value: controller.selectedSortOptions.value,
            hint: const Text('Filter'),
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.sort)
            ),
            onChanged: (value) => controller.sortProducts(value!),
            items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest'].map((filter) {
              return DropdownMenuItem(value: filter,child: Text(filter),);
            },).toList()
        ),

        const SizedBox(height: SSizes.spaceBtwSections),

        Obx(() =>  SGridLayout(itemCount: controller.products.length, itemBuilder: (context, index) => SProductCardVertical(product: controller.products[index])))
      ],
    );
  }
}