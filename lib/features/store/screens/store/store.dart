import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
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
    final dark = SHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
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
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: SSizes.spaceBtwItems),
                                itemCount: 10,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      width: SSizes.brandCardWidth,
                                      child: SBrandCard());
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottom: STabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Electronics')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetics'))
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              SCategoryTab(),
              SCategoryTab(),
              SCategoryTab(),
              SCategoryTab(),
              SCategoryTab()
            ],
          ),
        ),
      ),
    );
  }
}
