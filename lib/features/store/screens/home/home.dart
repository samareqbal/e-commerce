import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/home/home_controller.dart';
import 'package:upstore/features/store/controllers/product/product_controller.dart';
import 'package:upstore/features/store/models/product_model.dart';

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
import '../all_products/all_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final controller = Get.put(ProductController());
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

                  ),
        
                  const SizedBox(height: SSizes.spaceBtwSections),
        
                  //Section Heading
                  SSectionHeading(title: 'Popular Products',onPressed: ()=> Get.to(() => AllProductsScreen(
                    title: 'Popular Products',
                    futureMethod: controller.getAllFeaturedProducts(),
                  ))),
        
                  const SizedBox(height: SSizes.spaceBtwItems),
        
                  //Vertical product card and gridview
                  Obx(
                    (){

                      if(controller.isLoading.value){
                        return const Center(child: CircularProgressIndicator());
                      }


                      if(controller.products.isEmpty){
                        return const Center(child: Text("No Featured products found"));
                      }



                      return SGridLayout(
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = controller.products[index];
                          return SProductCardVertical(product: product);
                        },
                      );
                    }
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




