import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:upstore/features/store/controllers/brand/brand_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/products/sortable_products.dart';
import '../../models/brand_model.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title:
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SBrandCard(brand: brand),
              const SizedBox(height: SSizes.spaceBtwItems),
              FutureBuilder(
                future: brandController.getBrandProducts(brand.id),
                builder: (context, snapshot) {

                  const loader = SVerticalProductShimmer();

                  Widget? widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget != null) return widget;


                  List<ProductModel> products = snapshot.data!;
                  return SSortableProducts(products: products);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
