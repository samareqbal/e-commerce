import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../common/widgets/text_fields/search_bar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/custom_shapes/primary_header_container.dart';

class SStorePrimaryHeader extends StatelessWidget {
  const SStorePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Extra Box for search
        const SizedBox(height: SSizes.storePrimaryHeaderHeight + 10),

        //Primary Header
        SPrimaryHeaderContainer(
            height: SSizes.storePrimaryHeaderHeight,
            child: SAppBar(
              title: Text('Store',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: SColors.white)),
              actions: [SCartCounterIcon()],
            )),

        //Search Bar
        SSearchBar()
      ],
    );
  }
}