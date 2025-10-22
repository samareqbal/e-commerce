import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/layouts/grid_layout.dart';
import 'package:upstore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:upstore/features/store/controllers/product/product_controller.dart';
import 'package:upstore/features/store/screens/search_store/widgets/search_store_brands.dart';
import 'package:upstore/features/store/screens/search_store/widgets/search_store_categotries.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = "".obs;
    return Scaffold(
      appBar: SAppBar(showBackArrow: true, title: Text('Search', style: Theme.of(context).textTheme.headlineMedium)),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // allows tap detection on empty space
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // un focus text fields and hide keyboard
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: SPadding.screenPadding,
            child: Column(
              children: [
                Hero(
                  tag: 'search_animation',
                  child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) => searchText.value = value,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.search_normal),
                          hintText: 'Search in store'),
                    ),
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwSections),

                Obx((){
                  if(searchText.value.isEmpty){
                    return const Column(
                      children: [
                        SearchStoreBrands(),
                        SizedBox(height: SSizes.spaceBtwSections),
                        SearchStoreCategories()
                      ],
                    );
                  }

                  return FutureBuilder(
                      future: ProductController.instance.getAllProducts(),
                      builder: (context, snapshot) {


                        final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                        if(widget != null) return widget;

                        final products = snapshot.data!;
                        
                        final filteredProducts = products.where((product) => product.title.toLowerCase().contains(searchText.value.toLowerCase())).toList();
                        return SGridLayout(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return SProductCardVertical(product: product);
                          },
                        );
                      },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
