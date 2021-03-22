import 'package:flutter/material.dart';

import '../../theme.dart';

/// Текст поменьше
class SmallerText extends StatelessWidget {
  /// Текст
  final String text;

  /// Темный текст (по умолчанию серый)
  final bool dark;

  /// Светлый текст (по умолчанию серый)
  final bool light;

  /// Создает текст
  const SmallerText({
    Key? key,
    required this.text,
    this.dark = false,
    this.light = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: dark
            ? CustomColors.almostBlack
            : light
                ? CustomColors.lightGrey
                : CustomColors.grey,
        fontSize: 14,
      ),
    );
  }
}

/// Самый маленький текст
class SmallestText extends StatelessWidget {
  /// Текст
  final String text;

  /// Создает текст
  const SmallestText(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: CustomColors.grey,
        fontSize: 12,
      ),
    );
  }
}

/// Текст побольше
class BiggerText extends StatelessWidget {
  /// Текст
  final String text;

  /// Выравнивание текста
  final TextAlign align;

  /// Опциональный TextDecoration
  final TextDecoration? decoration;

  /// Опциональный цвет
  final Color? color;

  /// Создает текст
  const BiggerText({
    Key? key,
    required this.text,
    this.align = TextAlign.start,
    this.decoration,
    this.color = CustomColors.almostBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration,
        ),
        textAlign: align,
      );
}

/// Большуший текст
class BiggestText extends StatelessWidget {
  /// Текст
  final String text;

  /// Создает текст
  const BiggestText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: CustomColors.almostBlack,
      ),
    );
  }
}
