import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';

class AddHabitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var habit = useState(Habit.blank(userId));

    var titleTec = useTextEditingController(text: habit.value.title);
    titleTec.addListener(() {
      habit.value = habit.value.copyWith(title: titleTec.text);
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                await context
                    .read(habitControllerProvider.notifier)
                    .create(habit.value);
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleTec,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Название привычки, напр. "Зайти в приложение"',
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }
}
