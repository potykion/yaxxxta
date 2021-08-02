import 'package:flutter/material.dart';

/// Базовая карточка
class CoreCard extends StatelessWidget {
  /// Ребенок
  final Widget child;
  /// Цвет карточки
  final Color? color;
  /// Отступы
  final EdgeInsets? margin;
  /// Загруглять только верхушку
  final bool roundOnlyTop;

  /// Базовая карточка
  const CoreCard({
    Key? key,
    required this.child,
    this.color,
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    this.roundOnlyTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: roundOnlyTop
            ? BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              )
            : BorderRadius.circular(32),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: child,
      ),
    );
  }
}
