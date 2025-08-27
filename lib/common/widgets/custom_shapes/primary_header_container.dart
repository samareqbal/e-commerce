import 'package:flutter/material.dart';

import 'circular_container.dart';
import 'rounded_edges_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SPrimaryHeaderContainer extends StatelessWidget {
  const SPrimaryHeaderContainer({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SRoundedEdges(
      child: Container(
        height: height,
        color: SColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -160,
              child: SCircularContainer(
                height: SSizes.homePrimaryHeaderHeight,
                width: SSizes.homePrimaryHeaderHeight,
                backgroundColor: SColors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 50,
              right: -250,
              child: SCircularContainer(
                height: SSizes.homePrimaryHeaderHeight,
                width: SSizes.homePrimaryHeaderHeight,
                backgroundColor: SColors.white.withOpacity(0.1),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
