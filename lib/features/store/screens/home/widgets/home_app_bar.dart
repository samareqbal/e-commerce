import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../utils/constants/colors.dart';

class SHomeAppBar extends StatelessWidget {
  const SHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return SAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(SHelperFunctions.getGreetingMessage(),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: SColors.grey)),
          const SizedBox(height: SSizes.spaceBtwItems/4),

          Obx(() {
            if (controller.profileLoading.value) {
              return const SShimmerEffect(width: 80, height: 15);
            }

            return Text(controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: SColors.white));
          })
        ],
      ),
      actions: [SCartCounterIcon()],
    );
  }
}
