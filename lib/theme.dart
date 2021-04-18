import 'package:flutter/material.dart';

abstract class CustomColors {
  static final Color white = Color(0xffFFFFFC);
  static final Color grey = Color(0xff909590);
  static final Color lightGrey = Color(0xff909590).withAlpha(191);
  static final Color green = Color(0xffCAFFBF);
  static final Color darkGreen = Color(0xff000F08);
  static final Color yellow = Color(0xffFDFFB6);
}

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: CustomColors.yellow,
    appBarTheme: AppBarTheme(backgroundColor: CustomColors.white, elevation: 0),
    canvasColor: CustomColors.white,
    accentColor: CustomColors.green,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: CustomColors.lightGrey,
      backgroundColor: CustomColors.white,
      elevation: 0,
      selectedItemColor: CustomColors.darkGreen,
    ),
  );
}
