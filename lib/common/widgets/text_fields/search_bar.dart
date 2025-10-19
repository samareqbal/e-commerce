import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/shadow.dart';
import 'package:upstore/features/store/screens/search_store/search_store.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class SSearchBar extends StatelessWidget {
  const SSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    bool dark = SHelperFunctions.isDarkMode(context);

    return Positioned(
        bottom: 0,
        right: SSizes.spaceBtwSections,
        left: SSizes.spaceBtwSections,
        child: GestureDetector(
          onTap: () => Get.to(() => SearchStoreScreen()),
          child: Hero(
            tag: 'search_animation',
            child: Container(
              height: SSizes.searchBarHeight,
              padding: const EdgeInsets.symmetric(horizontal: SSizes.md),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
                  color: dark ? SColors.dark : SColors.light,
                  boxShadow: SShadow.searchBarShadow
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.search_normal,
                    color: SColors.darkGrey,
                  ),
                  const SizedBox(width: SSizes.spaceBtwItems),
                  Text(
                      STexts.searchBarTitle,
                      style: Theme.of(context).textTheme.bodySmall
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}