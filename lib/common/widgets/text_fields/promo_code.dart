import 'package:flutter/material.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/rounded_container.dart';

class SPromoCodeField extends StatelessWidget {
  const SPromoCodeField({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return SRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(left: SSizes.md,right: SSizes.sm,top: SSizes.sm,bottom: SSizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none
              ),
            ),
          ),

          SizedBox(
            width: 80,
            child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: SColors.grey.withValues(alpha: 0.2),
                    foregroundColor: dark ? SColors.white.withValues(alpha: 0.5) : SColors.dark.withValues(alpha: 0.5),
                    side: BorderSide(color: SColors.grey.withValues(alpha: 0.1))
                ),
                child: const Text("Apply")
            ),
          )
        ],
      ),
    );
  }
}