import 'package:flutter/material.dart';

class AppBarFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? text;

  const AppBarFab({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fab = text != null
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            label: Text(text!),
            icon: Icon(icon),
          )
        : FloatingActionButton(
            onPressed: onPressed,
            child: Icon(icon),
            mini: true,
          );

    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 8),
      child: fab,
    );
  }
}
