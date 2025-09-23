import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/products/sortable_products.dart';
import '../../models/brand_model.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title:
            Text('Adidas', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SBrandCard(brand: BrandModel.empty()),
              const SizedBox(height: SSizes.spaceBtwItems),
              SSortableProducts()
            ],
          ),
        ),
      ),
    );
  }
}
