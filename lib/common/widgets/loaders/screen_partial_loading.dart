import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SScreenPartialLoading extends StatelessWidget {
  const SScreenPartialLoading({super.key, this.isLoading = false, required this.child});

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        child,

        if(isLoading) Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              color: SColors.black.withValues(alpha: 0.5),
              child: const Center(child: CircularProgressIndicator(color: SColors.primary))),
        ),

      ],
    );
  }
}
