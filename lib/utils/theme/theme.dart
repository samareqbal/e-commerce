import 'package:flutter/material.dart';
import 'package:upstore/utils/theme/widgets_theme/appbar_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/bottom_sheet_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/checkbox_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/chip_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/elevated_button_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/outlined_button_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/text_field_theme.dart';
import 'package:upstore/utils/theme/widgets_theme/text_theme.dart';

import '../constants/colors.dart';

class SAppTheme{
  SAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: SColors.primary,
    disabledColor: SColors.grey,
    textTheme: STextTheme.lightTextTheme,
    chipTheme: SChipTheme.lightChipTheme,
    scaffoldBackgroundColor: SColors.white,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: SColors.primary,
    disabledColor: SColors.grey,
    textTheme: STextTheme.darkTextTheme,
    chipTheme: SChipTheme.darkChipTheme,
    scaffoldBackgroundColor: SColors.black,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}