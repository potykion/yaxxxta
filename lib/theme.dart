import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

@Deprecated("New colors available")
abstract class OldCustomColors {
  static final Color white = Color(0xffFFFFFC);
  static final Color grey = Color(0xff909590);
  static final Color lightGrey = Color(0xff909590).withAlpha(191);
  static final Color green = Color(0xffCAFFBF);
  static final Color darkGreen = Color(0xff000F08);
  static final Color yellow = Color(0xfff8f895);
// static final Color yellow = Color(0xff3d3c03);
}

abstract class CoreColors {
  static final Color darkPurple = Color(0xff272343);
  static final Color white = Colors.white;
  static final Color grey = Colors.grey;
  static final Color green = Color(0xffbae8e8);
  static final Color lightGreen = Color(0xfff1fafa);
}

abstract class CoreBorderRadiuses {
  static final double small = 16;
  static final double big = 32;
}

ThemeData buildThemeData(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: CoreColors.darkPurple,
      elevation: 0,
      foregroundColor: CoreColors.white,
    ),
    canvasColor: CoreColors.darkPurple,
    accentColor: CoreColors.green,
    cardColor: CoreColors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: CoreColors.green,
      unselectedItemColor: CoreColors.white,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: CoreColors.darkPurple,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CoreColors.green,
      foregroundColor: CoreColors.darkPurple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CoreColors.green),
        foregroundColor:
            MaterialStateProperty.all<Color>(CoreColors.darkPurple),
      ),
    ),
    textTheme: GoogleFonts.openSansTextTheme(
      textTheme.copyWith(
        headline4: TextStyle(
          color: CoreColors.white,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: CoreColors.darkPurple,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(color: CoreColors.darkPurple),
        bodyText1: TextStyle(color: CoreColors.darkPurple),
        bodyText2: TextStyle(color: CoreColors.darkPurple),
        subtitle1: TextStyle(color: CoreColors.darkPurple),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: CoreColors.darkPurple,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreBorderRadiuses.small),
        borderSide: BorderSide.none,
      ),
      fillColor: CoreColors.lightGreen,
      hintStyle: TextStyle(color: CoreColors.grey),
      filled: true,
    ),
    iconTheme: IconThemeData(
      color: CoreColors.darkPurple,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: CoreColors.white,
      dayPeriodColor: CoreColors.green,
      dayPeriodTextColor: CoreColors.darkPurple,
      dialBackgroundColor: CoreColors.white,
      dialHandColor: CoreColors.green,
      dialTextColor: CoreColors.darkPurple,
      entryModeIconColor: CoreColors.darkPurple,
      hourMinuteColor: CoreColors.green,
      hourMinuteTextColor: CoreColors.darkPurple,
      helpTextStyle: TextStyle(color: CoreColors.darkPurple),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreBorderRadiuses.big),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(CoreColors.darkPurple),
      ),
    ),
  );
}
