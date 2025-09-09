import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';

class SSingleAddress extends StatelessWidget {
  const SSingleAddress({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return SRoundedContainer(
        width: double.infinity,
        showBorder: true,
        padding: EdgeInsets.all(SSizes.md),
        backgroundColor: isSelected
            ? SColors.primary.withValues(alpha: 0.4)
            : Colors.transparent,
        borderColor: isSelected ? Colors.transparent : dark ? SColors.darkerGrey : SColors.grey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Samar Eqbal",
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: SSizes.spaceBtwItems/2),
                Text("+91 9709280453",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: SSizes.spaceBtwItems/2),
                Text("903, C1 Building, Hari Ganga Society, Yerwada, Pune"),
              ],
            ),
            if(isSelected) Positioned(
              top: 0,
                bottom: 0,
                right: 6,
                child: Icon(Iconsax.tick_circle5))
          ],
        ));
  }
}
