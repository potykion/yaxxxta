import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../deps.dart';

class DateSwiper extends HookWidget {
  final Widget Function(BuildContext context) builder;

  DateSwiper(this.builder);

  @override
  Widget build(BuildContext context) {
    var pageViewController = useState(PageController(initialPage: 1));

    return PageView.builder(
      itemCount: 3,
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
