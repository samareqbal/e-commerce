import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/layouts/grid_layout.dart';
import 'package:upstore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../common/widgets/products/sortable_products.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Popular Products', style: Theme.of(context).textTheme.headlineMedium),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
          child: SSortableProducts(),
        ),
      ),
    );
  }
}


