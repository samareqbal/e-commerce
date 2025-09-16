import 'package:flutter/material.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/texts/section_heading.dart';
import 'package:upstore/utils/constants/sizes.dart';

import '../../../../common/widgets/products/product_card/product_card_horizontal.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title:
            Text('Sports', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SSectionHeading(title: 'Sports Shoes', onPressed: () {}),
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              SizedBox(
                  height: 120,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: SSizes.spaceBtwItems / 2),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SProductCardHorizontal();
                    },
                  )),

              SSectionHeading(title: 'Sports Shoes', onPressed: () {}),
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              SizedBox(
                  height: 120,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                    const SizedBox(width: SSizes.spaceBtwItems / 2),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SProductCardHorizontal();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
