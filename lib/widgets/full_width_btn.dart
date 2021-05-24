import 'package:flutter/material.dart';

import '../theme.dart';

class FullWidthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isDanger;

  const FullWidthButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isDanger = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: isDanger
              ? ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.grey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.white),
                )
              : null,
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(text),
          ),
        ),
      );
}
