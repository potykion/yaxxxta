import 'package:hooks_riverpod/all.dart';
import 'package:tuple/tuple.dart';

/// Расширения для AsyncValue
extension AsyncValueExtensions<T1> on AsyncValue<T1> {
  /// Соединяет 2 AsyncValue в один
  AsyncValue<Tuple2<T1, T2>> merge2<T2>(AsyncValue<T2> asyncValue2) {
    var res = whenData((value) => Tuple2<T1, T2>(value, null));
    if (res.data == null) {
      return res;
    }

    asyncValue2.when(data: (value2) {
      res = AsyncValue.data(res.data.value.withItem2(value2));
    }, error: (error, trace) {
      res = AsyncValue.error(error, trace);
    }, loading: () {
      res = AsyncValue.loading();
    });

    return res;
  }
}
