import 'package:flutter/material.dart';

/// Базовый чип
class CoreChip extends StatelessWidget {
  /// Цвет
  final Color? color;

  /// Текст
  final String text;

  /// Иконка
  final IconData? icon;

  /// Базовый чип
  const CoreChip({
    Key? key,
    this.color,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        avatar: icon != null ? Icon(icon, color: color) : null,
        label: Text(text, style: TextStyle(color: color)),
      );
}
