import 'package:flutter/material.dart';

import '../../../theme.dart';

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
    Key key,
    this.text,
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

  /// Создает текст
  const BiggerText({
    Key key,
    this.text,
    this.align = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: CustomColors.almostBlack,
        ),
        textAlign: align,
      );
}

/// Большуший текст
class BiggestText extends StatelessWidget {
  /// Текст
  final String text;

  /// Добавить ли горизонтальный отступ
  final bool withPadding;

  /// Создает текст
  const BiggestText({Key key, this.text, this.withPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget res = Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: CustomColors.almostBlack,
      ),
    );

    if (withPadding) {
      res = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: res,
      );
    }

    return res;
  }
}
