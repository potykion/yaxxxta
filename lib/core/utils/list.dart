extension ListExtensions<T> on List<T> {
  List<T> distinctBy(dynamic Function(T item) by) {
    var uniqueByValues = this.map<dynamic>(by).toSet();
    return this..retainWhere((item) => uniqueByValues.remove(by(item)));
  }
}
