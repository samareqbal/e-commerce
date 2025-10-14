import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/brands/brand_card.dart';
import 'package:upstore/common/widgets/layouts/grid_layout.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/store/controllers/brand/brand_controller.dart';
import 'package:upstore/features/store/screens/brands/brand_products.dart';
import 'package:upstore/utils/constants/sizes.dart';


class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title:
            Text('Brands', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: SSizes.spaceBtwItems),
              Obx(
                (){

                  if(controller.isLoading.value){
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(controller.allBrands.isEmpty){
                    return const Center(child: Text('Brands not found'),);
                  }

                  return SGridLayout(
                    itemCount: controller.allBrands.length,
                    itemBuilder: (context, index) {
                      final brand = controller.allBrands[index];
                      return SBrandCard(
                        onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
                        brand: brand,
                      );
                    } ,
                    mainAxisExtent: 80,
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
