import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/category/category_controller.dart';
import 'package:upstore/features/store/models/category_model.dart';
import 'package:upstore/features/store/screens/all_products/all_products.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      if (controller.isCategoriesLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.allCategories.isEmpty) {
        return const Text("No Categories Found");
      }

      List<CategoryModel> categories =
          controller.allCategories;

      return Column(
        children: [
          SSectionHeading(
            title: 'Categories',
            showActionButton: false,
          ),
          const SizedBox(height: SSizes.spaceBtwItems),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return ListTile(
                onTap: () => Get.to(() => AllProductsScreen(
                      title: category.name,
                      futureMethod: controller.getCategoryProduct(
                          categoryId: category.id),
                    )),
                contentPadding: EdgeInsets.zero,
                leading: SRoundedImage(
                    imageUrl: category.image,
                    borderRadius: 0,
                    width: SSizes.iconLg,
                    height: SSizes.iconLg,
                    isNetworkImage: true),
                title: Text(category.name),
              );
            },
          ),
        ],
      );
    });
  }
}
