import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

enum Swipe { rightToLeft, leftToRight }

Swipe createSwipe(int indexFrom, int indexTo, int length) {
  if (indexFrom == 0 && indexTo == length - 1) return Swipe.leftToRight;
  if (indexFrom == length - 1 && indexTo == 0) return Swipe.rightToLeft;
  return indexFrom > indexTo ? Swipe.leftToRight : Swipe.rightToLeft;
}

typedef SwipeTo = Future<void> Function(int index, {bool toUnperformed});

class HabitSwiperController {
  List<HabitVM> habits;
  final bool swipeToNextUnperformed;

  late PageController pageController;
  int currentIndex = 0;
  bool swipeExact = false;

  int get habitCount => habits.length;

  HabitSwiperController({
    required this.habits,
    required this.swipeToNextUnperformed,
  }) {
    if (swipeToNextUnperformed) {
      currentIndex = max(
        getNextUnperformedHabitIndex(habits, includeInitial: true),
        0,
      );
    }
    pageController = PageController(
      initialPage: 1000 * habitCount + currentIndex,
    );
  }

  /// Функция, которая свайпает на страницу [normalizedIndexToSwipe]
  ///
  /// Если [toUnperformed] = true, то свайп осуществляется на очередную
  /// невыполненную привычку (в зависимости от направления свайпа)
  /// Если [swipeToNextUnperformed] = false,
  /// то будет свайп на очередную привычку
  void swipeTo(int indexToSwipe, {bool toUnperformed = false}) async {
    indexToSwipe = normalizeIndex(indexToSwipe);

    if (!toUnperformed) {
      var prevIndex = currentIndex;
      currentIndex = indexToSwipe;
      swipeExact = true;
      pageController.jumpToPage(
        pageController.page!.toInt() + indexToSwipe - prevIndex,
      );
      return;
    }

    if (!swipeToNextUnperformed) return;

    if (swipeExact) {
      swipeExact = false;
      return;
    }

    var swipe = createSwipe(currentIndex, indexToSwipe, habitCount);
    var indexGetter = swipe == Swipe.rightToLeft
        ? getNextUnperformedHabitIndex
        : getPreviousUnperformedHabitIndex;
    var nextIndex = indexGetter(
      habits,
      initialIndex: indexToSwipe,
      includeInitial: true,
    );

    currentIndex = indexToSwipe;

    if (nextIndex == -1 || nextIndex == indexToSwipe) return;

    if (swipe == Swipe.leftToRight) {
      // currentIndex = normalizeIndex(currentIndex - 1);

      await pageController.previousPage(
        curve: Curves.easeIn,
        duration: Duration(seconds: 1),
      );
    } else {
      await pageController.nextPage(
        curve: Curves.easeIn,
        duration: Duration(seconds: 1),
      );

    }
  }

  int normalizeIndex(int index) => index % habitCount;

  void setHabits(List<HabitVM> vms) {
    habits = vms;
    pageController = PageController(initialPage: 1000 * vms.length);
    currentIndex = 0;
  }
}

class HabitSwiper extends HookWidget {
  IndexedWidgetBuilder builder;
  HabitSwiperController controller;

  HabitSwiper({
    required this.builder,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: controller.pageController,
        itemBuilder: (context, index) =>
            builder(context, controller.normalizeIndex(index)),
        onPageChanged: (index) =>
            controller.swipeTo(index, toUnperformed: true),
      );
}
