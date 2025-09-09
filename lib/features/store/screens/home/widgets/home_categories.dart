import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/screens/sub_category/sub_category.dart';
import 'package:upstore/utils/constants/images.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SHomeCategories extends StatelessWidget {
  const SHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: SSizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            STexts.popularCategories,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: SColors.white),
          ),
          const SizedBox(height: SSizes.spaceBtwItems),
          SizedBox(
            height: 80,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(width: SSizes.spaceBtwItems),
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (context, index) {
                return SVerticalImageText(
                    title: 'Sports',
                    image: SImages.bagsIcon,
                    textColor: SColors.white,
                  onTap: () => Get.to(() => SubCategoryScreen()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
