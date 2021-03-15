import 'package:flutter/material.dart';

/// Кнопочка на весь экран
class FullWidthButton extends StatelessWidget {
  /// Событие нажатия кнопки
  final void Function()? onPressed;

  /// Ребенок
  final Widget child;

  /// Кнопочка на весь экран
  const FullWidthButton({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      );
}
