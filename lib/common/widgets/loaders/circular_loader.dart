import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SCircularLoader extends StatelessWidget {
  const SCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(SSizes.lg),
        decoration: const BoxDecoration(
            color: SColors.primary,
            shape: BoxShape.circle
        ),
        child: const CircularProgressIndicator(color: SColors.white,)
    );
  }
}
