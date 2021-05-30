import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/widgets/perform_habit_btn.dart';

import 'package:yaxxxta/routes.gr.dart';
import 'habit_performing_calendar.dart';

class HabitPerformingCard extends StatelessWidget {
  final HabitVM vm;
  final void Function()? onPerform;
  final void Function()? onArchive;

  const HabitPerformingCard({
    Key? key,
    required this.vm,
    this.onPerform,
    this.onArchive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                  // FloatingActionButton(
                  //   onPressed: () {},
                  //   child: Icon(Icons.edit),
                  //   mini: true,
                  //   elevation: 0,
                  //   foregroundColor: Color(0xff272343),
                  //   backgroundColor: Color(0xffe3f6f5),
                  // )
                ],
              ),
            ),
          ),
          // SizedBox(height: 16,),
          Expanded(
            child: Card(
              // elevation: 0,
              margin: EdgeInsets.only(
                top: 24,
                left: 4,
                right: 4,
                bottom: 4,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                    ],
                  ),
                  // SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                    ],
                  ),

                  //
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.today)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.list)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  // SizedBox(height: 8),
                ],
              ),
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
