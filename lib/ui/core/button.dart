import 'package:flutter/material.dart';

/// Базовая кнопочка
class CoreButton extends StatelessWidget {
  /// Текст
  final String text;
  /// Иконка
  final IconData icon;
  /// Событие нажатия
  final VoidCallback onPressed;

  /// Базовая кнопочка
  const CoreButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          // vertical: 8.0,
          ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            // elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
          ),
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
