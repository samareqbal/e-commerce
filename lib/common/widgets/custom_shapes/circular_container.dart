import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SCircularContainer extends StatelessWidget {
  const SCircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.backgroundColor = SColors.white,
    this.padding,
    this.margin,
    this.child
  });

  final double height, width;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000000), color: backgroundColor),
      child: child,
    );
  }
}
