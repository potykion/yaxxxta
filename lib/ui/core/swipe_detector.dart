import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Swipe { rightToLeft, leftToRight }

class SwipeDetector extends HookWidget {
  final Widget Function(BuildContext context) builder;
  final void Function(Swipe swipe) onSwipe;

  const SwipeDetector({
    Key? key,
    required this.builder,
    required this.onSwipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = useMemoized(() => PageController(initialPage: 999));
    var oldIndex = useState(999);

    return PageView.builder(
      controller: controller,
      itemBuilder: (context, __) => builder(context),
      onPageChanged: (newIndex) {
        onSwipe(
          oldIndex.value > newIndex ? Swipe.leftToRight : Swipe.rightToLeft,
        );
        oldIndex.value = newIndex;
      },
    );
  }
}
