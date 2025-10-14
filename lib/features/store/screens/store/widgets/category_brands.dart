import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:upstore/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:upstore/features/store/controllers/brand/brand_controller.dart';
import 'package:upstore/features/store/models/category_model.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              SListTileShimmer(),
              SizedBox(height: SSizes.spaceBtwItems),
              SBoxesShimmer(),
              SizedBox(height: SSizes.spaceBtwItems),
            ],
          );

          final widget = SCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);

          if (widget != null) {
            return widget;
          }

          final brands = snapshot.data!;

          return ListView.builder(
            itemCount: brands.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return FutureBuilder(
                future: controller.getBrandProducts(brand.id,limit: 3),
                builder: (context, snapshot) {


                  final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget != null){
                    return widget;
                  }


                  final products = snapshot.data!;

                  return SBrandShowCase(
                    brand: brand,
                    images: products.map((product) => product.thumbnail).toList(),
                  );
                },
              );
            },
          );
        });
  }
}
