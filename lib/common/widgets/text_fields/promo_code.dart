import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/controllers/promo_code/promo_code_controller.dart';
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
    final controller = PromoCodeController.instance;
    return SRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.only(
          left: SSizes.md, right: SSizes.sm, top: SSizes.sm, bottom: SSizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: controller.promoCodeTextController,
              onChanged: controller.onPromoChanged,
              decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none),
            ),
          ),
          Obx(
            () => SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: controller.appliedPromoCode.value.id.isNotEmpty
                      ? null
                      : controller.promoCode.isEmpty
                          ? null
                          : controller.applyPromoCode,
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: SColors.grey.withValues(alpha: 0.2),
                      // foregroundColor: dark ? SColors.white.withValues(alpha: 0.5) : SColors.dark.withValues(alpha: 0.5),
                      side: BorderSide(
                          color: SColors.grey.withValues(alpha: 0.1))),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: SSizes.lg,
                          width: SSizes.lg,
                          child:
                              CircularProgressIndicator(color: SColors.white))
                      : Text(controller.appliedPromoCode.value.id.isEmpty ? "Apply" : "Applied")),
            ),
          )
        ],
      ),
    );
  }
}
