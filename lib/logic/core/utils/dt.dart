/// Раширения дейттайма
extension DateTimeUtils on DateTime {
  /// Убирает время у дейттайма, то есть просто дата
  DateTime get date => DateTime(year, month, day);

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

  DateRange get weekDateRange => DateRange(
        add(Duration(days: 1 - weekday)).date,
        add(Duration(days: 7 - weekday)).date,
      );

  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfMonth => DateTime(year, month + 1, 0);
}

class DateRange {
  final DateTime from;
  final DateTime to;

  DateRange(this.from, this.to);

  List<DateTime> get dates => [
        for (var day
            in List.generate(to.difference(from).inDays + 1, (index) => index))
          from.add(Duration(days: day))
      ];

  DateTime? get firstMonthDay {
    final monthStarts = dates.where((d) => d == d.startOfMonth);
    if (monthStarts.isNotEmpty) return monthStarts.first;
    return null;
  }
}
