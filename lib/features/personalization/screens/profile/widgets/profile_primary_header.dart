import 'package:flutter/material.dart';
import 'package:upstore/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/primary_header_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/images/user_profile_logo.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';

class SProfilePrimaryHeader extends StatelessWidget {
  const SProfilePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: SSizes.profilePrimaryHeaderHeight + 60),
        SPrimaryHeaderContainer(
            height: SSizes.profilePrimaryHeaderHeight,
            child: Container()),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Center(
            child: UserProfileLogo(),
          ),
        )
      ],
    );
  }
}

