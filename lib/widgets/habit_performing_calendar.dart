import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

class HabitPerformingCalendar extends StatelessWidget {
  const HabitPerformingCalendar({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final HabitVM vm;

  @override
  Widget build(BuildContext context) {
    print(vm);
    return SizedBox(
      height: 250,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => _HabitPerformingsFor35Days(
          from: DateTime.now().subtract(Duration(days: 35 * index)),
          performings: vm.performings,
          habit: vm.habit,
        ),
      ),
    );
  }
}

class _HabitPerformingsFor35Days extends StatelessWidget {
  final DateTime from;
  final List<HabitPerforming> performings;
  final Habit habit;

  const _HabitPerformingsFor35Days({
    Key? key,
    required this.from,
    required this.performings,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var week in List.generate(5, (index) => index))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var day in List.generate(7, (index) => index))
                _buildDateCell(context, week, day)
            ],
          )
      ],
    );
  }

  Widget _buildDateCell(BuildContext context, int week, int day) {
    var date = from
        .subtract(
          Duration(days: week * 7 + day),
        )
        .date();
    var hasDatePerformings = performings.any((hp) => hp.created.date() == date);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: hasDatePerformings ? Theme.of(context).accentColor : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onLongPress: () => context
                  .read(habitControllerProvider.notifier)
                  .perform(habit, date),
              child: Container(
                width: 42,
                height: 42,
                child: Center(
                  child: Text(
                    DateFormat("dd.\nMM").format(date),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
