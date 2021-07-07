import 'package:flutter/material.dart';

class CoreChip extends StatelessWidget {
  final Color? color;
  final String text;
  final IconData? icon;

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
