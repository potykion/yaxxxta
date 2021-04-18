import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

import '../routes.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(Routes.add),
          )
        ],
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Swiper(
              key: ValueKey(vms.length),
              itemCount: vms.length,
              itemBuilder: (context, index) {
                var vm = vms[index];

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vm.habit.title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.done, size: 40),
                          onPressed: () => context
                              .read(habitControllerProvider.notifier)
                              .perform(vm.habit),
                        ),
                      ),
                      SizedBox(height: 10),
                      Performings(vm: vm),
                    ],
                  ),
                );
              },
              pagination: SwiperPagination(alignment: Alignment.topCenter),
            ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}

class Performings extends StatelessWidget {
  const Performings({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final HabitVM vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => PerformingsFor35Days(
          from: DateTime.now().subtract(Duration(days: 35 * index)),
          performings: vm.performings,
          habit: vm.habit,
        ),
      ),
    );
  }
}

class PerformingsFor35Days extends StatelessWidget {
  final DateTime from;
  final List<HabitPerforming> performings;
  final Habit habit;

  const PerformingsFor35Days({
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
                    style: TextStyle(
                      color: hasDatePerformings ? Colors.white : null,
                    ),
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
