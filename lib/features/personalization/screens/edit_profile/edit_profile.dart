import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';
import 'package:upstore/features/personalization/screens/change_name/change_name.dart';
import 'package:upstore/features/personalization/screens/edit_profile/widgets/user_profile_with_edit_icon.dart';
import 'package:upstore/utils/constants/sizes.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text("Edit Profile",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              UserProfileWithEditIcon(),
              const SizedBox(height: SSizes.spaceBtwSections),


              Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),


              SSectionHeading(title: 'Account Settings', showActionButton: false),
              const SizedBox(height: SSizes.spaceBtwItems),



              UserDetailsRow(title: 'Name', value: controller.user.value.fullName, onTap: () => Get.to(() => ChangeNameScreen())),
              UserDetailsRow(title: 'Username', value: controller.user.value.username, onTap: () {}),
              const SizedBox(height: SSizes.spaceBtwItems),

              //Profile section
              Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              SSectionHeading(title: 'Profile Settings', showActionButton: false),
              const SizedBox(height: SSizes.spaceBtwItems),

              UserDetailsRow(title: 'User ID', value: controller.user.value.id, onTap: () {}),
              UserDetailsRow(title: 'Email', value: controller.user.value.email, onTap: () {}),
              UserDetailsRow(title: 'Phone Number', value: '+91-${controller.user.value.phoneNumber}', onTap: () {}),
              UserDetailsRow(title: 'Gender', value: 'Male', onTap: () {}),
              const SizedBox(height: SSizes.spaceBtwItems),

              Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              TextButton(onPressed: () => controller.deleteAccountWarningPopup(), child: Text('Delete Account', style: TextStyle(color: Colors.red),))

            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailsRow extends StatelessWidget {
  const UserDetailsRow({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.onTap,
  });

  final String title, value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: SSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(title,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis)),
            Expanded(
                flex: 5,
                child: Text(value,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis)),
            Expanded(flex: 1, child: Icon(icon, size: SSizes.iconSm))
          ],
        ),
      ),
    );
  }
}
