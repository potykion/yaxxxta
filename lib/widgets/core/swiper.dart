import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Событие свайпа
typedef OnSwipe = void Function(bool isSwipeLeft);

/// Свайпер
class Swiper extends HookWidget {
  /// Ребенок
  final Widget Function(BuildContext context) builder;

  /// Событие свайпа
  final OnSwipe onSwipe;

  /// Свайпер
  Swiper({
    required this.builder,
    required this.onSwipe,
  });

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

        onSwipe(isSwipeLeft);
      },
      itemBuilder: (context, _) => builder(context),
    );
  }
}
