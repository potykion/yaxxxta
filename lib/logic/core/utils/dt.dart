/// Раширения дейттайма
extension DateTimeUtils on DateTime {
  /// Убирает время у дейттайма, то есть просто дата
  DateTime date() => DateTime(year, month, day);

  /// Чекает является ли дейттайм сегодняшним
  bool isToday() {
    var now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Соединяет дату и время
  DateTime combine(DateTime date, DateTime time) => DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second,
      );

  /// Двигает дейттайм на след день, относительно текущей даты
  DateTime setTomorrow() =>
      combine(DateTime.now().add(Duration(days: 1)), this);
}
