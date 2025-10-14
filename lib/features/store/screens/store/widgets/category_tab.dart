import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:upstore/features/store/controllers/category/category_controller.dart';
import 'package:upstore/features/store/models/category_model.dart';
import 'package:upstore/features/store/screens/all_products/all_products.dart';
import 'package:upstore/features/store/screens/store/widgets/category_brands.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(
                category: category,
              ),
              const SizedBox(height: SSizes.spaceBtwItems),
              SSectionHeading(
                  title: 'You might like',
                  onPressed: () => Get.to(() => AllProductsScreen(
                        title: category.name,
                        futureMethod: controller.getCategoryProduct(
                            categoryId: category.id, limit: -1),
                      ))),
              FutureBuilder(
                future: controller.getCategoryProduct(categoryId: category.id),
                builder: (context, snapshot) {
                  const loader = SVerticalProductShimmer(itemCount: 4);

                  final widget = SCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);

                  if (widget != null) {
                    return widget;
                  }

                  final products = snapshot.data!;

                  return SGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SProductCardVertical(
                          product: product);
                    },
                  );
                },
              ),
              const SizedBox(height: SSizes.spaceBtwSections)
            ],
          ),
        )
      ],
    );
  }
}
