import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/widgets/products/product_card/product_card_vertical.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class SSortableProducts extends StatelessWidget {
  const SSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
            hint: Text('Filter'),
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.sort)
            ),
            onChanged: (value) => {},
            items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest'].map((filter) {
              return DropdownMenuItem(value: filter,child: Text(filter),);
            },).toList()
        ),

        const SizedBox(height: SSizes.spaceBtwSections),

        SGridLayout(itemCount: 5, itemBuilder: (context, index) => SProductCardVertical())
      ],
    );
  }
}