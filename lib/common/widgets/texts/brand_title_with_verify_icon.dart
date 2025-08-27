import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/utils/constants/enums.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'brand_title_text.dart';

class SBrandTitleWithVerifyIcon extends StatelessWidget {
  const SBrandTitleWithVerifyIcon({
    super.key,
    required this.title,
    this.textColor,
    this.iconColor = SColors.primary,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final Color? textColor, iconColor;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SBrandTitleText(
            title: title,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSizes: brandTextSize,
            color: textColor,
          ),
        ),
        const SizedBox(width: SSizes.xs),
        const Icon(Iconsax.verify5, color: SColors.primary, size: SSizes.iconXs)
      ],
    );
  }
}
