import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

import 'habit_performing_calendar.dart';

class HabitPerformingCard extends StatelessWidget {
  final HabitVM vm;

  const HabitPerformingCard({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kToolbarHeight,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      vm.habit.title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    color: Color(0xffffffff),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Text(
                          "Прогресс",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: HabitPerformingCalendar(vm: vm),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ButtonWithIconAndText(
                          text: "Выполнить",
                          icon: Icons.done,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Text(
                          "Статистика",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "14",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text("Текущий стрик")
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "88",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text("Макс. стрик")
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(Icons.today),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(Icons.list),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWithIconAndText extends StatelessWidget {
  final String text;
  final IconData icon;

  const ButtonWithIconAndText({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(24),
            borderRadius: BorderRadius.circular(16),
          )),
        ),
        onPressed: () {},
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
