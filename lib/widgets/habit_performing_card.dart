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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            vm.habit.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Opacity(
                opacity: 0,
                // opacity: 1,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {},
                  child: Icon(Icons.edit),
                ),
              ),
              PerformHabitButton(
                vm: vm,
                onPerform: onPerform,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  var archived = await AutoRouter.of(context)
                      .push(HabitFormRoute(initial: vm.habit)) as bool?;
                  if ((archived ?? false) && onArchive != null) {
                    onArchive!();
                  }
                },
                child: Icon(Icons.edit),
              ),
            ],
          ),
          SizedBox(height: 20),
          HabitPerformingCalendar(vm: vm),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
