import 'package:flutter/material.dart';

class ButtonWithIconAndText extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonWithIconAndText({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
