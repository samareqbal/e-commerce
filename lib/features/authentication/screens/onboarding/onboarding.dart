import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:upstore/features/authentication/screens/onboarding/widgets/onbaording_page.dart';
import 'package:upstore/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:upstore/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:upstore/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:upstore/utils/constants/texts.dart';

import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
        child: Stack(
          children: [
            //Scrollable Page
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBoardingPage(
                  animation: SImages.onboarding1Animation,
                  title: STexts.onBoardingTitle1,
                  subTitle: STexts.onBoardingSubTitle1,
                ),
                OnBoardingPage(
                  animation: SImages.onboarding2Animation,
                  title: STexts.onBoardingTitle2,
                  subTitle: STexts.onBoardingSubTitle2,
                ),
                OnBoardingPage(
                  animation: SImages.onboarding3Animation,
                  title: STexts.onBoardingTitle3,
                  subTitle: STexts.onBoardingSubTitle3,
                ),
              ],
            ),

            //Skip Button
            OnBoardingSkipButton(),

            //Indicator
            OnBoardingDotNavigation(),

            //Bottom Button
            OnBoardingNextButton(),
          ],
        ),
      ),
    );
  }
}






