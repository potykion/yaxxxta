import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/core/text.dart';

import '../../theme.dart';

/// Календарь, на котором отображатся выполнения привычек
class HabitPerformingCalendar extends HookWidget {
  /// Привычка
  final HabitVM vm;

  /// Показывать скролбар
  final bool showScrollbar;

  final int months = 12;
  final int weeks = 5;

  /// Календарь, на котором отображатся выполнения привычек
  const HabitPerformingCalendar({
    Key? key,
    required this.vm,
    this.showScrollbar = kIsWeb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollController =
        useMemoized(() => PageController(initialPage: months - 1));

    Widget pv = PageView.builder(
      controller: scrollController,
      itemCount: months,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var now = DateTime.now();
        // Отматываем на 7 * 7 дней, где последний день будет вс
        var from = ((index == months - 1) ? now : now.weekDateRange.to)
            .subtract(Duration(days: weeks * 7 * (months - 1 - index)));

        return _HabitPerformingCalendarImpl(
          from: from,
          performings: vm.performings,
          habit: vm.habit,
          weeks: weeks,
        );
      },
    );

    return SizedBox(
      height: (weeks + 1) * (32 + 8),
      child: Column(
        children: [
          Row(
            children: [
              for (var weekday in List.generate(7, (index) => index + 1))
                Expanded(
                  child: Center(
                    child: Caption(
                      DateFormat(DateFormat.ABBR_WEEKDAY).format(
                        DateTime.now().add(
                            Duration(days: weekday - DateTime.now().weekday)),
                      ),
                    ),
                  ),
                )
            ],
          ),
          Expanded(child: pv),
        ],
      ),
    );
  }
}

class _HabitPerformingCalendarImpl extends StatelessWidget {
  final DateTime from;
  final List<HabitPerforming> performings;
  final Habit habit;
  final int weeks;

  const _HabitPerformingCalendarImpl({
    Key? key,
    required this.from,
    required this.performings,
    required this.habit,
    required this.weeks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var week in List.generate(weeks, (index) => index + 1))
          ..._buildMaybeMonthRowAndWeekRow(context, week)
      ],
    );
  }

  Widget _buildDateCell(BuildContext context, DateTime date) {
    late bool stopDrawDateCells;
    if (habit.frequencyType == HabitFrequencyType.daily) {
      stopDrawDateCells = date.isAfter(from);
    } else {
      stopDrawDateCells = false;
    }

    bool showPerformed;
    if (habit.frequencyType == HabitFrequencyType.daily) {
      showPerformed = performings.any((hp) => hp.created.date == date);
    } else {
      showPerformed = false;
    }

    bool boldWeekday = false;
    if (habit.frequencyType == HabitFrequencyType.weekly) {
      if (habit.performWeekday != null) {
        boldWeekday = date.weekday == habit.performWeekday!.index + 1;
      }
    }

    return Flexible(
      child: Center(
        child: stopDrawDateCells
            ? Container()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(CoreBorderRadiuses.small),
                  color: showPerformed ? Theme.of(context).accentColor : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(CoreBorderRadiuses.small),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onLongPress: () async {
                        await context
                            .read(habitCalendarStateProvider.notifier)
                            .perform(habit, date);
                        if (await Vibration.hasVibrator() ?? false) {
                          Vibration.vibrate(duration: 100);
                        }
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Text(
                            DateFormat("dd").format(date),
                            style: TextStyle(
                              fontWeight: boldWeekday ? FontWeight.bold : null,
                            ),
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

  List<Widget> _buildMaybeMonthRowAndWeekRow(BuildContext context, int week) {
    var dates = [
      for (var weekday in List.generate(7, (index) => index + 1))
        from
            .add(Duration(days: weekday - from.weekday))
            .subtract(Duration(days: (weeks - week) * 7))
            .date
    ];
    var monthDates = groupBy<DateTime, int>(dates, (d) => d.month).values;
    var currentMonthDates = monthDates.first;
    var nextMonthDates = monthDates.skip(1).firstOrNull ?? [];

    bool showPerformed;
    if (habit.frequencyType == HabitFrequencyType.daily) {
      showPerformed = false;
    } else {
      showPerformed = performings.any((hp) => dates.contains(hp.created.date));
    }

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: currentMonthDates.length == 7
                    ? CoreBorderRadiuses.smallFullBorder
                    : CoreBorderRadiuses.smallLeftBorder,
                color: showPerformed ? CoreColors.green : null,
              ),
              child: Row(
                children: [
                  for (var date in currentMonthDates)
                    _buildDateCell(context, date),
                ],
              ),
            ),
            flex: currentMonthDates.length,
          ),
          for (var _ in nextMonthDates)
            Expanded(child: Center(child: Container())),
        ],
      ),
      if (nextMonthDates.isNotEmpty)
        Row(
          children: [
            Expanded(
              child: Center(
                child: Caption(
                  DateFormat(DateFormat.ABBR_MONTH)
                      .format(nextMonthDates.first),
                  bold: true,
                ),
              ),
            ),
            Expanded(child: Center(child: Container()), flex: 6),
          ],
        ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var _ in currentMonthDates)
            Expanded(child: Center(child: Container())),
          Expanded(
            flex: nextMonthDates.length,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: currentMonthDates.length == 7
                    ? CoreBorderRadiuses.smallFullBorder
                    : CoreBorderRadiuses.smallRightBorder,
                color: showPerformed ? CoreColors.green : null,
              ),
              child: Row(
                children: [
                  for (var date in nextMonthDates)
                    _buildDateCell(context, date),
                ],
              ),
            ),
          )
        ],
      )
    ];
  }
}
