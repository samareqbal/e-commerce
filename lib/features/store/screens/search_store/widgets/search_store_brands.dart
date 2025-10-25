import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/brand/brand_controller.dart';
import 'package:upstore/features/store/models/brand_model.dart';
import 'package:upstore/features/store/screens/brands/all_brands.dart';
import 'package:upstore/features/store/screens/brands/brand_products.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    final dark = SHelperFunctions.isDarkMode(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.allBrands.isEmpty) {
        return const Text("No Brands Found");
      }

      List<BrandModel> brands = controller.allBrands.take(10).toList();

      return Column(
        children: [
          SSectionHeading(title: 'Brands' ,onPressed: () => Get.to(() => BrandScreen()),),
          const SizedBox(height: SSizes.spaceBtwItems),
          Wrap(
              spacing: SSizes.spaceBtwItems,
              runSpacing: SSizes.spaceBtwItems,
              children: brands
                  .map((brand) => SVerticalImageText(
                onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
                      title: brand.name,
                      image: brand.image,
                      textColor: dark ? SColors.white : SColors.black))
                  .toList()),
        ],
      );
    });
  }
}
