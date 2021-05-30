import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CustomColors {
  static final Color white = Color(0xffFFFFFC);
  static final Color grey = Color(0xff909590);
  static final Color lightGrey = Color(0xff909590).withAlpha(191);
  static final Color green = Color(0xffCAFFBF);
  static final Color darkGreen = Color(0xff000F08);
  static final Color yellow = Color(0xfff8f895);
// static final Color yellow = Color(0xff3d3c03);
}

ThemeData buildThemeData(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return ThemeData(
    primaryColor: CustomColors.yellow,
    appBarTheme: AppBarTheme(backgroundColor: CustomColors.white, elevation: 0),
    // canvasColor: Color(0xffF9FDFD),
    canvasColor: Color(0xffffffff),
    accentColor: Color(0xffbae8e8),
    cardColor: Color(0xffe3f6f5),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe3f6f5)),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
        foregroundColor: MaterialStateProperty.all<Color>(Color(0xff272343)),
      ),
    ),
    textTheme: GoogleFonts.openSansTextTheme(
      textTheme.copyWith(
        headline4: TextStyle(color: Color(0xff272343), fontWeight: FontWeight.bold),
        headline3: TextStyle(color: Color(0xff272343), fontWeight: FontWeight.bold),
      ),
    ),
  );
}
