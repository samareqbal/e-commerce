import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/common/widgets/layouts/grid_layout.dart';
import 'package:upstore/common/widgets/loaders/animation_loader.dart';
import 'package:upstore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:upstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:upstore/features/store/controllers/product/favourite_controller.dart';
import 'package:upstore/navigation_menu.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../utils/constants/images.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          SCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
            child: Obx(
                () => FutureBuilder(
                future: FavouriteController.instance.getFavouriteProducts(),
                builder: (context, snapshot) {

                  final nothingFound = SAnimationLoader(
                      text: 'Wishlist is Empty',
                    animation: SImages.pencilAnimation,
                    showActionButton: true,
                    actionText: "Let's add some",
                    onActionPressed: () => NavigationController.instance.selectedIndex.value = 0,
                  );
                  const loader = SVerticalProductShimmer(itemCount: 6);


                  final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader,nothingFound: nothingFound);
                  if(widget != null) return widget;


                  final products = snapshot.data!;



                  return SGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        SProductCardVertical(product: products[index]),
                  );
                },
              ),
            )),
      ),
    );
  }
}
