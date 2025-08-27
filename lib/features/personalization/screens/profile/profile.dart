import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/features/personalization/screens/profile/widgets/profile_primary_header.dart';
import 'package:upstore/features/personalization/screens/profile/widgets/settings_menu_tile.dart';
import 'package:upstore/features/personalization/screens/profile/widgets/user_profile_tile.dart';
import 'package:upstore/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            //Header
            SProfilePrimaryHeader(),
        
        
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  UserProfileTile(),
        
                  const SizedBox(height: SSizes.spaceBtwItems),
        
                  SSectionHeading(title: 'Account Settings', showActionButton: false),
        
                  //Settings menu
                  SettingsMenuTile(
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    icon: Iconsax.safe_home,
                  ),
                  SettingsMenuTile(
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    icon: Iconsax.shopping_cart,
                  ),
                  SettingsMenuTile(
                    title: 'My orders',
                    subTitle: 'In-progress and Completed Orders',
                    icon: Iconsax.bag_tick,
                  ),

                  const SizedBox(height: SSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                      child: OutlinedButton(onPressed: (){}, child: Text('Logout'))),

                  const SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}






