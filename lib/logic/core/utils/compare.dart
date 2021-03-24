import 'package:tuple/tuple.dart';
import 'list.dart';

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

/// Добавляет сравнение для списков
extension ListExtensions on List {
  /// Добавляет сравнение для списков
  int compareTo(List list) {
    var itemComparisons = mapWithIndex(
      (dynamic item, index) => compareDynamic(item, list[index]),
    );
    for (var comparison in itemComparisons) {
      if (comparison == 0) continue;
      return comparison;
    }
    return 0;
  }
}

/// Сравнивает динамику
int compareDynamic(dynamic item1, dynamic item2) {
  if (item1 == item2) return 0;
  if (item1 == null && item2 != null) return -1;
  if (item1 != null && item2 == null) return 1;

  if (item1 is Comparable && item2 is Comparable) {
    return (item1).compareTo(item2);
  }

  if (item1 is bool && item2 is bool) return item1 ? 1 : -1;

  throw "Хз как сравнивать";
}
