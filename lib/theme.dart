import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

@Deprecated("New colors available")
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
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff272343),
        elevation: 0,
        foregroundColor: Color(0xffffffff),
      ),
      canvasColor: Color(0xff272343),
      // accentColor: Color(0xffe3f6f5),
      accentColor: Color(0xffbae8e8),
      cardColor: Color(0xffffffff),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xffbae8e8),
        unselectedItemColor: Color(0xffffffff),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Color(0xff272343),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        // backgroundColor: Color(0xffffffff),
        backgroundColor: Color(0xffbae8e8),
        foregroundColor: Color(0xff272343),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffbae8e8)),
          // backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe3f6f5)),
          foregroundColor: MaterialStateProperty.all<Color>(Color(0xff272343)),
        ),
      ),
      textTheme: GoogleFonts.openSansTextTheme(
        textTheme.copyWith(
          headline4: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: Color(0xff272343),
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Color(0xff272343),
            // color: Colors.grey,
            // fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(color: Color(0xff272343)),
          bodyText2: TextStyle(color: Color(0xff272343)),
          subtitle1: TextStyle(color: Color(0xff272343)),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Color(0xff272343),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        fillColor: Color(0xfff1fafa),
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
      ),
      iconTheme: IconThemeData(
        color: Color(0xff272343),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        dayPeriodColor: Color(0xffbae8e8),
        dayPeriodTextColor: Color(0xff272343),
        dialBackgroundColor: Colors.white,
        dialHandColor: Color(0xffbae8e8),
        dialTextColor: Color(0xff272343),
        entryModeIconColor: Color(0xff272343),
        hourMinuteColor: Color(0xffbae8e8),
        hourMinuteTextColor: Color(0xff272343),
        helpTextStyle: TextStyle(color: Color(0xff272343)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Color(0xff272343)),
      )));
}
