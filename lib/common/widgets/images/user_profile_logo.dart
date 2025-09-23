import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/shimmer/shimmer_effect.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/images.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(
      () {
        bool isProfilePictureAvailable = controller.user.value.profilePicture.isNotEmpty;


        if(controller.isProfilePictureUploading.value){
          return SShimmerEffect(width: 120, height: 120, radius: 120);
        }

        return SCircularImage(
          image: isProfilePictureAvailable ? controller.user.value.profilePicture : SImages.profileLogo,
          height: 120,
          width: 120,
          borderWidth: 5.0,
          padding: 0,
          isNetworkImage: isProfilePictureAvailable ? true : false,
        );
      }
    );
  }
}