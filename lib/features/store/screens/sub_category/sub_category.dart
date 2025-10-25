import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/store/controllers/category/category_controller.dart';
import 'package:upstore/features/store/models/category_model.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/features/store/screens/all_products/all_products.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/product_card/product_card_horizontal.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(category.name,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: FutureBuilder(
            future: controller.getSubCategories(category.id),
            builder: (context, snapshot) {
              const loader = SHorizontalProductShimmer();

              final widget = SCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);
              if (widget != null) return widget;

              final subCategories = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: subCategories.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  CategoryModel subCategory = subCategories[index];

                  //fetch products for sub categories
                  return FutureBuilder(
                    future: controller.getCategoryProduct(
                        categoryId: subCategory.id),
                    builder: (context, snapshot) {
                      final widget =
                          SCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      List<ProductModel> products = snapshot.data!;

                      return Column(
                        children: [
                          SSectionHeading(
                              title: subCategory.name,
                              onPressed: () => Get.to(() => AllProductsScreen(
                                    title: subCategory.name,
                                    futureMethod: controller.getCategoryProduct(
                                        categoryId: subCategory.id, limit: -1),
                                  ))),
                          const SizedBox(height: SSizes.spaceBtwItems / 2),
                          SizedBox(
                              height: 120,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                        width: SSizes.spaceBtwItems / 2),
                                itemCount: products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return SProductCardHorizontal(
                                      product: product);
                                },
                              )),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
