import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/common/widgets/loaders/animation_loader.dart';
import 'package:upstore/utils/constants/colors.dart';
import 'package:upstore/utils/helpers/helper_functions.dart';

class SFullScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: SHelperFunctions.isDarkMode(Get.context!)
                  ? SColors.dark
                  : SColors.light,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  SAnimationLoader(text: text)
                ],
              ),
            )));
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
