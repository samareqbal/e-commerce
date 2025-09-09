import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Adidas',style: Theme.of(context).textTheme.headlineMedium),
      ),

      body: SingleChildScrollView(
        child: Padding(padding: SPadding.screenPadding, child: Column(
          children: [

          ],
        ),),
      ),
    );
  }
}
