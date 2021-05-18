import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/ui/calendar/app/habit_swiper.dart';

void main() {
  test("createSwipe", () {
    // [0, 1, 2, 3, 4, 5, 6] = 7

    expect(createSwipe(0, 1, 7), Swipe.rightToLeft);
    expect(createSwipe(1, 0, 7), Swipe.leftToRight);
    expect(createSwipe(0, 6, 7), Swipe.leftToRight);
    expect(createSwipe(6, 5, 7), Swipe.leftToRight);
    expect(createSwipe(6, 0, 7), Swipe.rightToLeft);
  });
}