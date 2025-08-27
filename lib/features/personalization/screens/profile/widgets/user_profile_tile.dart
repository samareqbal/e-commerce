import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/features/personalization/screens/edit_profile/edit_profile.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('Samar Eqbal',style: Theme.of(context).textTheme.headlineSmall),
      subtitle: Text('test@gmail.com', style: Theme.of(context).textTheme.bodyMedium),
      trailing: IconButton(icon: Icon(Iconsax.edit), onPressed: () => Get.to(() => EditProfileScreen())),
    );
  }
}