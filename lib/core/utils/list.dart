/// Экстеншены списка
extension ListExtensions<E> on List<E> {
  /// Удаляет дубликаты, применяя функцию ко всем элементам
  List<E> distinctBy(dynamic Function(E item) by) {
    var uniqueByValues = map<dynamic>(by).toSet();
    return this..retainWhere((item) => uniqueByValues.remove(by(item)));
  }

  Iterable<T> mapWithIndex<T>(T f(E item, int index)) =>
      asMap().entries.map((e) => f(e.value, e.key));
}
