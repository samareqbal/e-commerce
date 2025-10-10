import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:upstore/features/store/controllers/product/all_product_controller.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/sortable_products.dart';
import '../../models/product_model.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, this.futureMethod, this.query, required this.title});

  final Future<List<ProductModel>>? futureMethod;
  final Query? query;
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SPadding.screenPadding,
            child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                const loader = SVerticalProductShimmer();
                final widget = SCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);

                if (widget != null) {
                  return widget;
                }

                final products = snapshot.data!;
                return SSortableProducts(products: products);
              },
            )),
      ),
    );
  }
}
