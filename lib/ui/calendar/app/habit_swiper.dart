import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

enum Swipe { rightToLeft, leftToRight }

Swipe createSwipe(int indexFrom, int indexTo, int length) {
  if (indexFrom > indexTo) return Swipe.leftToRight;
  return Swipe.rightToLeft;
}

typedef SwipeTo = Future<void> Function(int index, {bool toUnperformed});
typedef HabitSwiperItemBuilder = Widget Function(
    BuildContext context, int index, SwipeTo swipeTo);


class HabitSwiper extends HookWidget {
  final HabitSwiperItemBuilder builder;
  final List<HabitVM> habits;
  final PageController controller;

  int get habitCount => habits.length;

  HabitSwiper({
    required this.builder,
    required this.habits,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var swipeToNextUnperformedEnabled =
        useProvider(swipeToNextUnperformedProvider);

    var initialPage = useMemoized(
      () => swipeToNextUnperformedEnabled
          ? max(getNextUnperformedHabitIndex(habits, includeInitial: true), 0)
          : 0,
    );

    /// Функция, которая свайпает на страницу [indexToSwipe]
    ///
    /// Если [toUnperformed] = true, то свайп осуществляется на очередную
    /// невыполненную привычку (в зависимости от направления свайпа)
    /// Если [swipeToNextUnperformed] = false,
    /// то будет свайп на очередную привычку
    swipeTo(int indexToSwipe, {bool toUnperformed = false}) async {
      if (!toUnperformed) {
        controller.jumpToPage(1000 * habitCount + indexToSwipe);
        return;
      }

      if (!swipeToNextUnperformedEnabled) return;

      var swipe = createSwipe(initialPage, indexToSwipe, habitCount);
      var indexGetter = swipe == Swipe.rightToLeft
          ? getNextUnperformedHabitIndex
          : getPreviousUnperformedHabitIndex;

      var nextIndex = indexGetter(
        habits,
        initialIndex: indexToSwipe,
        includeInitial: true,
      );
      if (nextIndex == -1 || nextIndex == indexToSwipe) return;

      controller.jumpToPage(1000 * habitCount + nextIndex);
    }

    return PageView.builder(
      controller: controller,
      itemBuilder: (context, index) => builder(
        context,
        index % habitCount,
        swipeTo,
      ),
      onPageChanged: (index) => swipeTo(
        index % habitCount,
        toUnperformed: true,
      ),
    );
  }
}
