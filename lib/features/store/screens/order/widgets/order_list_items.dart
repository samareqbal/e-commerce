import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/loaders/animation_loader.dart';
import 'package:upstore/features/store/controllers/order/order_controller.dart';
import 'package:upstore/navigation_menu.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/cloud_helper_functions.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../models/order_model.dart';

class SOrderListItems extends StatelessWidget {
  const SOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {


          final nothingFound = SAnimationLoader(
              text: 'No orders yet!',
              showActionButton: true,
            actionText: "Let's fill it",
            animation: SImages.pencilAnimation,
            onActionPressed: () => Get.offAll(() => NavigationMenu()),
          );

          final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot ,nothingFound:  nothingFound);
          if(widget != null) return widget;

          final orders = snapshot.data!;

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: SSizes.spaceBtwItems),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              OrderModel order = orders[index];
              return SRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? SColors.dark : SColors.light,
                padding: const EdgeInsets.all(SSizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [


                    Row(
                      children: [
                        Icon(Iconsax.ship),

                        const SizedBox(width: SSizes.spaceBtwItems/2),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.orderStatusText, style: Theme.of(context).textTheme.bodyLarge!.apply(color: SColors.primary, fontWeightDelta: 1)),
                              Text(order.formattedOrderDate , style: Theme.of(context).textTheme.headlineSmall)
                            ],
                          ),
                        ),

                        IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_34, size: SSizes.iconSm))
                      ],
                    ),

                    const SizedBox(height: SSizes.spaceBtwItems),


                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Iconsax.tag),

                              const SizedBox(width: SSizes.spaceBtwItems/2),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order ID', style: Theme.of(context).textTheme.labelMedium),
                                    Text(order.id, style: Theme.of(context).textTheme.titleMedium)
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        Expanded(
                          child: Row(
                            children: [
                              Icon(Iconsax.calendar),

                              const SizedBox(width: SSizes.spaceBtwItems/2),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Shipping date', style: Theme.of(context).textTheme.labelMedium),
                                    Text(order.formattedDeliveryDate , style: Theme.of(context).textTheme.titleMedium)
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },);
        },
    );
  }
}
