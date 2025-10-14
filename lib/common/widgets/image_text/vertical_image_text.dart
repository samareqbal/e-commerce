import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/images/circular_image.dart';

import '../../../utils/constants/sizes.dart';

class SVerticalImageText extends StatelessWidget {
  const SVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
  });

  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [

          //Circular Image
          SCircularImage(
            height: 56,
              width: 56,
              image: image,isNetworkImage: true,
          ),

          // SCircularContainer(
          //   height: 56,
          //   width: 56,
          //   padding: const EdgeInsets.all(SSizes.sm),
          //   backgroundColor:
          //       backgroundColor ?? (dark ? SColors.dark : SColors.light),
          //   child: Image(
          //     image: AssetImage(image),
          //     fit: BoxFit.cover,
          //   ),
          // ),

          const SizedBox(height: SSizes.spaceBtwItems / 2),

          //Title
          SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
