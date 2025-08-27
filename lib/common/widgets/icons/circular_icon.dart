import 'package:flutter/material.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

class SCircularIcon extends StatelessWidget {
  const SCircularIcon(
      {super.key,
      this.height,
      this.width,
      this.size = SSizes.iconMd,
      this.icon,
      this.color,
      this.backgroundColor,
      this.onPressed});

  final double? height, width, size;
  final IconData? icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: (backgroundColor != null)
            ? backgroundColor
            : dark
                ? SColors.dark.withOpacity(0.9)
                : SColors.light.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}
