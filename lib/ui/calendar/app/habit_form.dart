import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/models.dart';

import 'button_with_icon_and_text.dart';
import 'habit_info_card.dart';

class HabitForm extends HookWidget {
  final Habit? initial;

  HabitForm({this.initial});

  @override
  Widget build(BuildContext context) {
    var habit = useState(
      initial ?? Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid),
    );

    var titleTec = useTextEditingController(text: habit.value.title);
    titleTec.addListener(() {
      habit.value = habit.value.copyWith(title: titleTec.text);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              habit.value.id != null ? "Редактирование" : "Создание",
              style: Theme.of(context).textTheme.headline4,
            ),
            Opacity(
              opacity: habit.value.id != null ? 1 : 0,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              "Название",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 8),
            TextFormField(
              style: TextStyle(color: Colors.white),
              readOnly: habit.value.archived,
              controller: titleTec,
              decoration: InputDecoration(
                hintText: 'Например, "Зайти в приложение"',
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 8),
            ButtonWithIconAndText(
              icon: Icons.save,
              text: "Сохранить",
              onPressed: () {},
            ),
            SizedBox(height: 8),
          ],
        )
      ],
    );
  }
}
