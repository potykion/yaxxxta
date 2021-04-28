import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

import '../theme.dart';

class HabitFormPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habit = useState(
      (ModalRoute.of(context)!.settings.arguments as Habit?) ??
          Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid),
    );

    var titleTec = useTextEditingController(text: habit.value.title);
    titleTec.addListener(() {
      habit.value = habit.value.copyWith(title: titleTec.text);
    });

    return WebPadding(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.done),
                onPressed: () async {
                  if (habit.value.id != null) {
                    await context
                        .read(habitControllerProvider.notifier)
                        .update(habit.value);
                  } else {
                    await context
                        .read(habitControllerProvider.notifier)
                        .create(habit.value);
                  }

                  Navigator.of(context).pop();
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Название привычки",
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(padding: EdgeInsets.only(bottom: 4)),
              TextFormField(
                controller: titleTec,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Например "Зайти в приложение"',
                  filled: true,
                ),
              ),
              Spacer(),
              if (habit.value.id != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.white),
                    ),
                    onPressed: () async {
                      context.read(selectedHabitIndexProvider).state = 0;
                      await context
                          .read(habitControllerProvider.notifier)
                          .archive(habit.value);
                      Navigator.of(context).pop();
                    },
                    child: Text("Архивировать"),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
