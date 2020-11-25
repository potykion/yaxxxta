import 'package:flutter/material.dart';
import 'package:yaxxxta/view_models.dart';
import 'package:yaxxxta/widgets.dart';

class HabitEditPage extends StatelessWidget {
  get hasId => false;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    BiggerText(text: "Тип"),
                    Spacer(),
                    if (hasId) SmallerText(text: "нельзя изменить")
                  ],
                ),
                SizedBox(height: 5),
                HabitTypeInput(
                  initial: HabitType.repeats,
                  change: (type) => print(type),
                  setBefore: hasId,
                ),
              ],
            )
          ],
        ),
      );
}
