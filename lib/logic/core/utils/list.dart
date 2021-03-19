/// Экстеншены списка
extension ListExtensions<E> on List<E> {
  /// Удаляет дубликаты, применяя функцию ко всем элементам
  List<E> distinctBy(dynamic Function(E item) by) {
    var uniqueByValues = map<dynamic>(by).toSet();
    return this..retainWhere((item) => uniqueByValues.remove(by(item)));
  }

  /// Применяет функцию с индексом
  Iterable<T> mapWithIndex<T>(T f(E item, int index)) =>
      asMap().entries.map((e) => f(e.value, e.key));

  /// Режет список на списки размером {size}
  /// https://stackoverflow.com/a/22274155/5500609
  Iterable<List<E>> chunked({int size = 2}) sync* {
    for (var i = 0; i < length; i += size) {
      yield sublist(i, i + size > length ? length : i + size);
    }
  }
}
