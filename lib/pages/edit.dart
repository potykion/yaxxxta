import 'package:flutter/material.dart';
import 'package:yaxxxta/view_models.dart';
import 'package:yaxxxta/widgets.dart';

class HabitEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            PaddedContainerCard(
              children: [
                BiggerText(text: "Название"),
                SizedBox(height: 5),
                TextInput(),
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "Тип"),
                SizedBox(height: 5),
                HabitTypeInput(
                  initial: HabitType.repeats,
                  change: (type) {},
                ),
              ],
            )
          ],
        ),
      );
}
