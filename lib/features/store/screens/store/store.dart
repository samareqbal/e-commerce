import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/shimmer/brands_shimmer.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/store/controllers/brand/brand_controller.dart';
import 'package:upstore/features/store/controllers/category/category_controller.dart';
import 'package:upstore/features/store/screens/brands/all_brands.dart';
import 'package:upstore/features/store/screens/store/widgets/category_tab.dart';
import 'package:upstore/features/store/screens/store/widgets/store_primary_header.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final brandController = Get.put(BrandController());
    return DefaultTabController(
      length: controller.featuredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Header
                      SStorePrimaryHeader(),

                      const SizedBox(height: SSizes.spaceBtwItems),

                      //Brand heading
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SSizes.defaultSpace),
                        child: Column(
                          children: [
                            SSectionHeading(title: 'Brands', onPressed: () => Get.to(() => BrandScreen())),

                            //Brand Card
                            SizedBox(
                              height: SSizes.brandCardHeight,
                              child: Obx(
                                  () {


                                    if(brandController.isLoading.value){
                                      return SBrandShimmer();
                                    }

                                    if(brandController.featuredBrands.isEmpty){
                                      return Text('Brands not found');
                                    }

                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                      const SizedBox(width: SSizes.spaceBtwItems),
                                      itemCount: brandController.featuredBrands.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {

                                        final brand = brandController.featuredBrands[index];

                                        return SizedBox(
                                            width: SSizes.brandCardWidth,
                                            child: SBrandCard(brand: brand));
                                      },
                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottom: STabBar(
                  tabs: controller.featuredCategories.map((category) => Tab(child: Text(category.name))).toList()
                ),
              )
            ];
          },
          body: TabBarView(
            children: controller.featuredCategories.map((category) => SCategoryTab()).toList()
          ),
        ),
      ),
    );
  }
}
