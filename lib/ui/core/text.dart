import 'package:flutter/material.dart';

/// Заголовок 4
class Headline4 extends StatelessWidget {
  /// Текст
  final String text;

  /// Стиль
  final TextStyle? style;

  /// Заголовок 4
  const Headline4(
    this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline4!.merge(style),
      );
}

/// Заголовок 5
class Headline5 extends StatelessWidget {
  /// Текст
  final String text;

  /// Виджет в конце заголовка
  final Widget? trailing;

  /// Стиль
  final TextStyle? style;

  /// Центрирование заголовка
  final bool center;

  /// Заголовок 5
  const Headline5(
    this.text, {
    Key? key,
    this.trailing,
    this.style,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline5!.merge(style),
          ),
          if (trailing != null) trailing!
        ],
      );
}

/// Заголовок 6
class Headline6 extends StatelessWidget {
  /// Текст
  final String text;

  /// Беленький текст
  final bool white;

  /// Заголовок 6
  const Headline6(this.text, {Key? key, this.white = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.headline6!;
    if (white) {
      style = style.copyWith(color: Colors.white);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, style: style),
    );
  }
}

/// Надпись маленькая
class Caption extends StatelessWidget {
  /// Текст
  final String text;

  /// Надпись маленькая
  const Caption(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: TextStyle(color: Colors.grey));
}
