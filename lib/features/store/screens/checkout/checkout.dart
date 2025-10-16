import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/style/padding.dart';
import 'package:upstore/common/widgets/appbar/appbar.dart';
import 'package:upstore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:upstore/common/widgets/screens/success_screen.dart';
import 'package:upstore/features/store/controllers/cart/cart_controller.dart';
import 'package:upstore/features/store/controllers/order/order_controller.dart';
import 'package:upstore/features/store/screens/cart/widgets/cart_items.dart';
import 'package:upstore/features/store/screens/checkout/widgets/billind_address_section.dart';
import 'package:upstore/features/store/screens/checkout/widgets/billing_amount_section.dart';
import 'package:upstore/features/store/screens/checkout/widgets/billing_payment_section.dart';
import 'package:upstore/navigation_menu.dart';
import 'package:upstore/utils/constants/images.dart';
import 'package:upstore/utils/constants/sizes.dart';
import 'package:upstore/utils/helpers/pricing_calculator.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

import '../../../../common/widgets/button/elevated_button.dart';
import '../../../../common/widgets/text_fields/promo_code.dart';
import '../../../../utils/constants/texts.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    double subTotal = controller.totalCartPrice.value;
    double total = SPricingCalculator.calculateTotalPrice(subTotal, "India");
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Order Review',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SPadding.screenPadding,
          child: Column(
            children: [
              SCartItems(showAddRemoveButtons: false),
              const SizedBox(height: SSizes.spaceBtwSections),
              SPromoCodeField(),
              const SizedBox(height: SSizes.spaceBtwSections),
              SRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(SSizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    SBillingAmountSection(),
                    const SizedBox(height: SSizes.spaceBtwItems),
                    SBillingPaymentSection(),
                    const SizedBox(height: SSizes.spaceBtwItems),
                    SBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: SElevatedButton(
            onPressed: subTotal > 0 ? () => orderController.processOrder(total) : () => SSnackBarHelpers.errorSnackBar(title: 'Empty Cart', message: 'Add items to cart'),
            child: Text('Checkout ${STexts.currency}$total')),
      ),
    );
  }
}
