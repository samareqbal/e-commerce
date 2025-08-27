import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/home/home_controller.dart';

import 'package:upstore/features/store/screens/home/widgets/home_app_bar.dart';
import 'package:upstore/features/store/screens/home/widgets/home_categories.dart';
import 'package:upstore/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:upstore/features/store/screens/home/widgets/promo_slider.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../common/widgets/text_fields/search_bar.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Upper Part
            Stack(
              children: [
                //Extra Box for s
                const SizedBox(height: SSizes.homePrimaryHeaderHeight + 10),
        
                //Primary Header
                SPrimaryHeaderContainer(
                  height: SSizes.homePrimaryHeaderHeight,
                    child: Column(
                  children: [
                    //AppBar
                    SHomeAppBar(),
        
                    const SizedBox(height: SSizes.spaceBtwSections),
        
                    //Home Categories
                    SHomeCategories()
                  ],
                )),
        
                //Search Bar
                SSearchBar()
              ],
            ),
        
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  //Banners
                  SPromoSlider(
                    banners: [
                      SImages.homeBanner1,
                      SImages.homeBanner2,
                      SImages.homeBanner3,
                      SImages.homeBanner4,
                      SImages.homeBanner5,
                      SImages.homeBanner6,
                    ],
                  ),
        
                  const SizedBox(height: SSizes.spaceBtwSections),
        
                  //Section Heading
                  SSectionHeading(title: 'Popular Products',onPressed: (){}),
        
                  const SizedBox(height: SSizes.spaceBtwItems),
        
                  //Vertical product card and gridview
                  SGridLayout(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SProductCardVertical();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




