import 'package:flutter/material.dart';
import 'package:upstore/utils/helpers/device_helpers.dart';

class SElevatedButton extends StatelessWidget {
  const SElevatedButton({
    super.key, required this.onPressed, required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SDeviceHelper.getScreenWidth(context),
      child: ElevatedButton(
          onPressed: onPressed,
          child: child
      ),
    );
  }
}