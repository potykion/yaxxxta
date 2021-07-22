import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Базовые цвета
abstract class CoreColors {
  static final Color darkPurple = Color(0xff272343);
  static final Color white = Colors.white;
  static final Color grey = Colors.grey;
  static final Color green = Color(0xffbae8e8);
  static final Color lightGreen = Color(0xfff1fafa);
}

/// Базовые радиусы
abstract class CoreBorderRadiuses {
  static final double small = 16;
  static final double big = 32;

  static BorderRadius get smallLeftBorder => BorderRadius.only(
        topLeft: Radius.circular(CoreBorderRadiuses.small),
        bottomLeft: Radius.circular(CoreBorderRadiuses.small),
      );

  static BorderRadius get smallRightBorder => BorderRadius.only(
        topRight: Radius.circular(CoreBorderRadiuses.small),
        bottomRight: Radius.circular(CoreBorderRadiuses.small),
      );

  static BorderRadius get smallFullBorder =>
      BorderRadius.circular(CoreBorderRadiuses.small);
}

/// Базовые паддинги
abstract class CorePaddings {
  static final double smallest = 4;
  static final double small = 8;
  static final double big = 16;
}

ThemeData buildThemeData(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return ThemeData(
    brightness: Brightness.light,
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

          subtitle2: TextStyle(color: CoreColors.darkPurple),
          caption: TextStyle(color: CoreColors.darkPurple),
          button: TextStyle(color: CoreColors.darkPurple),
          overline: TextStyle(color: CoreColors.darkPurple),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: CoreColors.darkPurple,
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
        textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: CoreColors.darkPurple)),
        foregroundColor:
            MaterialStateProperty.all<Color>(CoreColors.darkPurple),
      ),
    ),

  );
}
