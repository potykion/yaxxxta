import 'package:tuple/tuple.dart';

/// Добавляет сравнение для тьюплов
extension TupleExtensions on Tuple2 {
  /// Добавляет сравнение для тьюплов
  int compareTo(Tuple2 tuple) {
    var item1Compare = compareDynamic(item1, tuple.item1);
    if (item1Compare != 0) return item1Compare;
    var item2Compare = compareDynamic(item2, tuple.item2);
    return item2Compare;
  }
}

/// Сравнивает динамику
int compareDynamic(dynamic item1, dynamic item2) {
  if (item1 is Comparable && item2 is Comparable) {
    return (item1).compareTo(item2);
  }

  if (item1 is bool && item2 is bool) {
    return item1 == item2
        ? 0
        : item1
            ? 1
            : -1;
  }

  throw "Хз как сравнивать";
}
