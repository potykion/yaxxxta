import 'package:tuple/tuple.dart';
import 'package:yaxxxta/core/utils/async_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/all.dart';

void main() {
  group("AsyncValueExtensions.merge2", () {
    test("AsyncValueExtensions.merge2", () {
      var asyncValue1 = AsyncValue.data(1);
      var asyncValue2 = AsyncValue.data(2);

      expect(asyncValue1.merge2(asyncValue2).data.value, Tuple2(1, 2));
    });

    test("AsyncValueExtensions.merge2 second loading", () {
      var asyncValue1 = AsyncValue.data(1);
      var asyncValue2 = AsyncValue<int>.loading();

      expect(asyncValue1.merge2(asyncValue2).data, null);
      expect(asyncValue1.merge2(asyncValue2),
          AsyncValue<Tuple2<int, int>>.loading());
    });

    test("AsyncValueExtensions.merge2 first loading", () {
      var asyncValue1 = AsyncValue<int>.loading();
      var asyncValue2 = AsyncValue<int>.loading();

      expect(asyncValue1.merge2(asyncValue2).data, null);
      expect(asyncValue1.merge2(asyncValue2),
          AsyncValue<Tuple2<int, int>>.loading());
    });
  });
}
