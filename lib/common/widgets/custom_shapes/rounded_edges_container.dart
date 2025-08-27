import 'package:flutter/cupertino.dart';
import 'package:upstore/common/widgets/custom_shapes/clipper/custom_rounded_clipper.dart';

class SRoundedEdges extends StatelessWidget {
  const SRoundedEdges({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SCustomRoundEdges(),
      child: child,
    );
  }
}
