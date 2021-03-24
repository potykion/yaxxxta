import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/view_models.dart';

/// Свайпер даты
class DateSwiper extends HookWidget {
  /// Ребенок
  final Widget Function(BuildContext context) builder;

  /// Свайпер даты
  DateSwiper(this.builder);

  @override
  Widget build(BuildContext context) {
    /// Ставим большое число для отрицательного скрола
    /// https://stackoverflow.com/a/50429599/5500609
    var initialIndex = useState(1488);
    var pageViewController = useState(PageController(initialPage: 1488));

    return PageView.builder(
      controller: pageViewController.value,
      onPageChanged: (index) {
        var isSwipeLeft = index > initialIndex.value;
        initialIndex.value = index;

        var newDate = context
            .read(selectedDateProvider)
            .state
            .add(Duration(days: isSwipeLeft ? 1 : -1));

        context.read(selectedDateProvider).state = newDate;
        context
            .read(habitPerformingController)
            .loadDateHabitPerformings(newDate);
      },
      itemBuilder: (context, _) => builder(context),
    );
  }
}
