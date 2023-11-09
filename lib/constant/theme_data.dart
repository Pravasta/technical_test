import 'package:flutter/material.dart';

import 'app_colors.dart';

class ThemeDataColor {
  static ThemeData darkColor = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.blackColor,
  );

  static ThemeData lightColor = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.whiteColor,
  );
}
