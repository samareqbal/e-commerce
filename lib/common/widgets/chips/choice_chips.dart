import 'package:flutter/material.dart';
import 'package:upstore/common/widgets/custom_shapes/circular_container.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class SChoiceChip extends StatelessWidget {
  const SChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
  });

  final String text;
  final bool selected;
  final Function(bool?) onSelected;

  @override
  Widget build(BuildContext context) {
    bool isColor = SHelperFunctions.getColor(text) != null;
    return ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? SColors.white : null),
        shape: isColor ? CircleBorder() : null,
        padding: isColor ? EdgeInsets.zero : null,
        labelPadding: isColor ? EdgeInsets.zero : null,
        backgroundColor: isColor ? SHelperFunctions.getColor(text) : null,
        avatar: isColor ? SCircularContainer(width: 50,
            height: 50,
            backgroundColor: SHelperFunctions.getColor(text)!) : null

    );
  }
}
