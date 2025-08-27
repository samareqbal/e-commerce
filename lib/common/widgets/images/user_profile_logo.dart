import 'package:flutter/material.dart';

import '../../../utils/constants/images.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SCircularImage(
      image: SImages.profileLogo,
      height: 120,
      width: 120,
      borderWidth: 5.0,
    );
  }
}