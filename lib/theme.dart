import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Кастомные цвета
abstract class CustomColors {
  /// Красный
  static const Color red = Color(0xffFFADAD);

  /// Оранжевый
  static const Color orange = Color(0xffFFD6A5);

  /// Желтый
  static const Color yellow = Color(0xffFDFFB6);

  /// Зеленый
  static const Color green = Color(0xffCAFFBF);

  /// Голубой
  static const Color cyan = Color(0xff9BF6FF);

  /// Синий
  static const Color blue = Color(0xffA0C4FF);

  /// Фиолетовый
  static const Color purple = Color(0xffBDB2FF);

  /// Розовый
  static const Color pink = Color(0xffFFC6FF);

  /// Почти черный
  static const Color almostBlack = Color(0xff3D3A4B);

  /// Легкий серый
  static const Color lightGrey = Color(0xffFAFAFA);

  /// Серый
  static const Color grey = Color(0xffBCBCBC);
}

/// Создает тему приложухи
ThemeData buildTheme(BuildContext context) => ThemeData(
      primaryColor: CustomColors.almostBlack,
      accentColor: CustomColors.yellow,
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: CustomColors.lightGrey,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      timePickerTheme: TimePickerThemeData(
        // Цвет текста в таймпикере
        hourMinuteTextColor: CustomColors.almostBlack,
        // Цвет периода дня (am/pm)
        dayPeriodTextColor: CustomColors.almostBlack,
      ),
      // Хайлайт выбора часа/минут в таймпикере
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: CustomColors.yellow,
            onPrimary: CustomColors.almostBlack,
          ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: CustomColors.almostBlack,
        ),
      ),
    );
