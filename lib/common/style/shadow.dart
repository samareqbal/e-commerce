import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class SShadow{
  SShadow._();

  static List<BoxShadow> searchBarShadow = [
    BoxShadow(
        color: SColors.black.withOpacity(0.1),
        spreadRadius: 2.0,
        blurRadius: 4.0)
  ];

  static List<BoxShadow> verticalProductShadow = [
    BoxShadow(
        color: SColors.darkGrey.withOpacity(0.1),
        blurRadius: 50,
        spreadRadius: 7,
        offset: const Offset(0,2)
    )
  ];
}