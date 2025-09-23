import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upstore/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance =>  Get.find();

  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  final localStorage = GetStorage();

  @override
  void onClose() {
    if (pageController.hasClients) {
      pageController.dispose();
    }
    super.onClose();
  }

  //Update current index while page scroll
  void updatePageIndicator(index){
    currentIndex.value = index;
  }

  //Jump to specific dot selected page
  void dotNavigationClick(index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
    // pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  //Update current index and jump to next page
  void nextPage(){
    if(currentIndex.value == 2){
      localStorage.write('isFirstTime', false);
      Get.offAll(() => const LoginScreen());
    }else{
      currentIndex.value++;
     //pageController.jumpToPage(currentIndex.value);
      int page = currentIndex.value + 1;


      // Check if pageController is attached before animating
      if (pageController.hasClients) {
        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

  }

  //Update current index and jump to last page
  void skipPage(){
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);

  }
}