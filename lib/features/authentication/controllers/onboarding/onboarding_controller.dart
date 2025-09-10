import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upstore/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance =>  Get.find();

  final pageController = PageController();
  RxInt currentIndex = 0.obs;

  final localStorage = GetStorage();

  //Update current index while page scroll
  void updatePageIndicator(index){
    currentIndex.value = index;

  }

  //Jump to specific dot selected page
  void dotNavigationClick(index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  //Update current index and jump to next page
  void nextPage(){
    if(currentIndex.value == 2){
      localStorage.write('isFirstTime', false);
      Get.offAll(() => const LoginScreen());
    }else{
      currentIndex.value++;
      pageController.jumpToPage(currentIndex.value);
    }

  }

  //Update current index and jump to last page
  void skipPage(){
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);
  }
}