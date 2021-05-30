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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    vm.habit.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  color: Color(0xff272343),
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
          // SizedBox(height: 16,),
          Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Opacity(
                //       opacity: 0,
                //       // opacity: 1,
                //       child: FloatingActionButton(
                //         heroTag: null,
                //         onPressed: () {},
                //         child: Icon(Icons.edit),
                //       ),
                //     ),
                //     PerformHabitButton(
                //       vm: vm,
                //       onPerform: onPerform,
                //     ),
                //     FloatingActionButton(
                //       heroTag: null,
                //       elevation: 0,
                //       onPressed: () async {
                //         var archived = await AutoRouter.of(context)
                //             .push(HabitFormRoute(initial: vm.habit)) as bool?;
                //         if ((archived ?? false) && onArchive != null) {
                //           onArchive!();
                //         }
                //       },
                //       child: Icon(Icons.edit),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 8.0,
                    vertical: 12,
                  ),
                  child: HabitPerformingCalendar(vm: vm),
                ),
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
      // width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          // elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
        ),
        onPressed: () {},
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
