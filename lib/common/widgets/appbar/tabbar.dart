import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/device_helpers.dart';
import '../../../utils/helpers/helper_functions.dart';

class STabBar extends StatelessWidget implements PreferredSizeWidget {
  const STabBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? SColors.black : SColors.white,
      child: TabBar(
          isScrollable: true,
          labelColor: SColors.primary,
          unselectedLabelColor: SColors.darkGrey,
          indicatorColor: SColors.primary,
          tabs: tabs
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SDeviceHelper.getAppBarHeight());
}