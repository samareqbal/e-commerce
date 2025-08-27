import 'package:flutter/material.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class SFormDivider extends StatelessWidget {
  const SFormDivider({
    super.key,
     required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(child: Divider(indent: 60, endIndent: 5, thickness: 1,color: dark? SColors.darkerGrey : SColors.grey)),
        Text(title,style: Theme.of(context).textTheme.labelMedium,),
        Expanded(child: Divider(indent: 5, endIndent: 60, thickness: 1,color: dark? SColors.darkerGrey : SColors.grey)),
      ],
    );
  }
}