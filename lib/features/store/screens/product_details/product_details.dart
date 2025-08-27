import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/icons/circular_icon.dart';
import 'package:upstore/common/widgets/images/circular_image.dart';
import 'package:upstore/common/widgets/images/rounded_image.dart';
import 'package:upstore/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:upstore/common/widgets/texts/product_price_text.dart';
import 'package:upstore/common/widgets/texts/product_title_text.dart';
import 'package:upstore/features/store/screens/product_details/widgets/product_meta_data.dart';
import 'package:upstore/features/store/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../utils/constants/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [
            SProductThumbnailAndSlider(),

            SProductMetaData()
          ],
        ),
      ),
    );
  }
}


