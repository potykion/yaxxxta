/// Экстеншены списка
extension ListExtensions<T> on List<T> {
  /// Удаляет дубликаты, применяя функцию ко всем элементам
  List<T> distinctBy(dynamic Function(T item) by) {
    var uniqueByValues = map<dynamic>(by).toSet();
    return this..retainWhere((item) => uniqueByValues.remove(by(item)));
  }
}
