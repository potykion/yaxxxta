import 'package:flutter/material.dart';

class NoHabitsLabel extends StatelessWidget {
  const NoHabitsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Что-то не видать привычек",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Заведи привычку, нажав на ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
