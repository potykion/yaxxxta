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

  /// Красит текст в красный
  final bool error;

  /// Создает текст
  const SmallerText({
    Key? key,
    required this.text,
    this.dark = false,
    this.light = false,
    this.error = false,
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
                : error
                    ? CustomColors.red
                    : CustomColors.grey,
        fontSize: 12,
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

  /// Если true, то делает текст серым и зачеркнутым
  final bool disabled;

  /// Создает текст
  const BiggerText({
    Key? key,
    required this.text,
    this.align = TextAlign.start,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: disabled ? CustomColors.grey : CustomColors.almostBlack,
          decoration: disabled ? TextDecoration.lineThrough : null,
        ),
        textAlign: align,
        overflow: TextOverflow.fade,
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

/// Текст обычного размера
class RegularText extends StatelessWidget {
  /// Текст
  final String text;

  /// Если true, то текст серый
  final bool disabled;

  /// Текст обычного размера
  const RegularText(
    this.text, {
    Key? key,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: disabled ? CustomColors.grey : null,
      ),
    );
  }
}
