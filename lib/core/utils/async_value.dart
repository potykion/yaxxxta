import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

/// Расширения для AsyncValue
extension AsyncValueExtensions<T1> on AsyncValue<T1> {
  /// Соединяет 2 AsyncValue в один
  AsyncValue<Tuple2<T1, T2>> merge2<T2>(AsyncValue<T2> asyncValue2) {
    /// Если data == null => res - AsyncValue.error / AsyncValue.loading
    /// => Используем костыль null!
    // ignore: null_check_always_fails
    var res = whenData((value) => Tuple2<T1, T2>(value, null!));
    if (data == null) {
      return res;
    }

    asyncValue2.when(data: (value2) {
      res = AsyncValue.data(Tuple2(data!.value, value2));
    }, error: (error, trace) {
      res = AsyncValue.error(error, trace);
    }, loading: () {
      res = AsyncValue.loading();
    });

    return res;
  }
}
