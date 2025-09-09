import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

class SOrderListItems extends StatelessWidget {
  const SOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: SSizes.spaceBtwItems),
      itemCount: 15,
      itemBuilder: (context, index) {
      return SRoundedContainer(
        showBorder: true,
        backgroundColor: dark ? SColors.dark : SColors.light,
        padding: EdgeInsets.all(SSizes.md),
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
                      Text('Processing', style: Theme.of(context).textTheme.bodyLarge!.apply(color: SColors.primary, fontWeightDelta: 1)),
                      Text('09 Sep 2025' , style: Theme.of(context).textTheme.headlineSmall)
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
                            Text('12345' , style: Theme.of(context).textTheme.titleMedium)
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
                            Text('10 Sep 2025' , style: Theme.of(context).textTheme.titleMedium)
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
  }
}
