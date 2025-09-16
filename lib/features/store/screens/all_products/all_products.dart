import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';

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


