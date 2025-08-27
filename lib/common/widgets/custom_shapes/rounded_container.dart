import 'package:flutter/material.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/constants/sizes.dart';

class SRoundedContainer extends StatelessWidget {
  const SRoundedContainer(
      {super.key,
      this.height,
      this.width,
      this.radius = SSizes.cardRadiusLg,
      this.child,
      this.showBorder = false,
      this.borderColor = SColors.borderPrimary,
      this.backgroundColor = SColors.white,
      this.padding,
      this.margin});

  final double? height, width;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null
      ),
      child: child,
    );
  }
}
