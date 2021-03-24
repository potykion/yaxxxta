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
    var pageViewController = useState(PageController(initialPage: 1));

    return PageView.builder(
      controller: pageViewController.value,
      onPageChanged: (index) {
        var newDate = context
            .read(selectedDateProvider)
            .state
            .add(Duration(days: index > 1 ? 1 : -1));
        context.read(selectedDateProvider).state = newDate;
        context
            .read(habitPerformingController)
            .loadDateHabitPerformings(newDate);
      },
      itemBuilder: (context, _) => builder(context),
    );
  }
}
