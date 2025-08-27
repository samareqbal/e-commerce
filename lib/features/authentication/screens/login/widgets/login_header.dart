import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SLoginHeader extends StatelessWidget {
  const SLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title
        Text(STexts.loginTitle ,style: Theme.of(context).textTheme.headlineMedium,),

        const SizedBox(height: SSizes.sm,),

        //SubTitle
        Text(STexts.loginSubTitle ,style: Theme.of(context).textTheme.bodySmall,)
      ],
    );
  }
}