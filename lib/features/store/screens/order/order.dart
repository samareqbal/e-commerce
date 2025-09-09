import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/features/store/screens/order/widgets/order_list_items.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('My Orders', style: Theme
            .of(context)
            .textTheme
            .headlineMedium),
      ),

      body: Padding(
          padding: SPadding.screenPadding,
          child: SOrderListItems()
      ),
    );
  }
}
