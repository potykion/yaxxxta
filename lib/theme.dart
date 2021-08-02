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
      // brightness: Brightness.light,
      canvasColor: CoreColors.darkPurple,
      colorScheme: ColorScheme(
        primary: CoreColors.green,
        primaryVariant: CoreColors.lightGreen,
        secondary: CoreColors.darkPurple,
        secondaryVariant: CoreColors.lightGreen,
        surface: CoreColors.white,
        background: CoreColors.darkPurple,
        error: CoreColors.darkPurple,
        onPrimary: CoreColors.darkPurple,
        onSecondary: CoreColors.darkPurple,
        onSurface: CoreColors.darkPurple,
        onBackground: CoreColors.white,
        onError: CoreColors.darkPurple,
        brightness: Brightness.light,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: CoreColors.white,
      ),
      textTheme: GoogleFonts.openSansTextTheme(
        textTheme.copyWith(
          headline4: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
      chipTheme: ChipThemeData(
        backgroundColor: CoreColors.lightGreen,
        secondarySelectedColor: CoreColors.green,
        disabledColor: CoreColors.grey,
        selectedColor: CoreColors.darkPurple,
        padding: EdgeInsets.all(4),
        labelStyle: TextStyle(color: CoreColors.darkPurple),
        secondaryLabelStyle: TextStyle(),
        brightness: Brightness.light,
      ));
}
