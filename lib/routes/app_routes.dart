import 'package:get/get.dart';
import 'package:upstore/navigation_menu.dart';
import 'package:upstore/routes/routes.dart';

import '../features/authentication/screens/forget_password/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/edit_profile/edit_profile.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/store/screens/cart/cart.dart';
import '../features/store/screens/checkout/checkout.dart';
import '../features/store/screens/order/order.dart';
import '../features/store/screens/store/store.dart';
import '../features/store/screens/wishlist/wishlist.dart';

class SAppRoutes{
  static final screens = [
    GetPage(name: SRoutes.home, page: () => const NavigationMenu()),
    GetPage(name: SRoutes.store, page: () => const StoreScreen(),),
    GetPage(name: SRoutes.wishlist, page: () => const WishListScreen(),),
    GetPage(name: SRoutes.profile, page: () => const ProfileScreen(),),
    GetPage(name: SRoutes.order, page: () => const OrderScreen(),),
    GetPage(name: SRoutes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: SRoutes.cart, page: () => const CartScreen(),),
    GetPage(name: SRoutes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: SRoutes.userAddress, page: () => const AddressScreen(),),
    GetPage(name: SRoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: SRoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    GetPage(name: SRoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: SRoutes.forgetPassword, page: () => const ForgetPasswordScreen(),),
    GetPage(name: SRoutes.onBoarding, page: () => OnboardingScreen(),),
  ];
}