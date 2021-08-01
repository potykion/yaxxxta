import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Базовые цвета
abstract class CoreColors {
  /// Темно-фиолетовый
  static final Color darkPurple = Color(0xff272343);

  /// Беленький
  static final Color white = Colors.white;

  /// Серый
  static final Color grey = Colors.grey;

  /// Зеленый
  static final Color green = Color(0xffbae8e8);

  /// Слегка зеленый
  static final Color lightGreen = Color(0xfff1fafa);
}

/// Базовые радиусы
abstract class CoreBorderRadiuses {
  /// Маленький радиус
  static final double small = 16;
  /// Большой радиус
  static final double big = 32;

  /// Слегка закругленная граница слева
  /// (звучит как машинный перевод лол)
  static BorderRadius get smallLeftBorder => BorderRadius.only(
        topLeft: Radius.circular(CoreBorderRadiuses.small),
        bottomLeft: Radius.circular(CoreBorderRadiuses.small),
      );

  /// Слегка закругленная граница справа
  static BorderRadius get smallRightBorder => BorderRadius.only(
        topRight: Radius.circular(CoreBorderRadiuses.small),
        bottomRight: Radius.circular(CoreBorderRadiuses.small),
      );

  /// Слегка закругленная граница со всех сторон
  static BorderRadius get smallFullBorder =>
      BorderRadius.circular(CoreBorderRadiuses.small);
}

/// Базовые паддинги / отступы
abstract class CorePaddings {
  /// Совсем малюсенький отступ
  static final double smallest = 4;
  /// Маленький отступ
  static final double small = 8;
  /// Большой отступ
  static final double big = 16;
}

/// Создает тему
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
