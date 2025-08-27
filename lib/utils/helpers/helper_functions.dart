import 'package:flutter/material.dart';

class SHelperFunctions{
  SHelperFunctions._();

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
}