import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'dt.freezed.dart';

/// @nodoc
extension DurationUtils on Duration {
  /// Форматирует дюрейшн без нулей впереди и без миллисекунд, типа 1:02:03
  String format() => [
        inHours > 0 ? inHours : null,
        inMinutes > 0 ? inMinutes % 60 : null,
        inSeconds % 60
      ]
          .where((d) => d != null)
          .toList()
          .asMap()
          .entries
          .map((e) => e.key == 0 ? e.value : e.value.toString().padLeft(2, "0"))
          .join(":");
}

/// Форматирует время (20:43)
String formatTime(DateTime time) => DateFormat.Hm().format(time);

/// Собирает дейттайм из даты и времени
DateTime buildDateTime(DateTime date, DateTime time) => DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

/// Определяет день, когда месяц заканчивается
int endOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0).day;

/// Определяет номер дня в рамках года
int yearDayNum(DateTime date) =>
    date.difference(DateTime(date.year, 1, 1)).inDays + 1;

/// Определяет номер недели в рамках года
int yearWeekNum(DateTime date) {
  var yearStartWeek = DateTime(date.year, 1, 1)
      .subtract(Duration(days: DateTime(date.year, 1, 1).day));

  return date.difference(yearStartWeek).inDays ~/ 7 + 1;
}

/// @nodoc
extension DateTimeUtils on DateTime {
  /// Создает дейт тайм без времени, то есть просто дейт
  DateTime date() => DateTime(year, month, day);

  /// Создает дейт тайм с фиксированной датой, то есть просто тайм
  DateTime time({bool withSeconds = false, DateTime date}) => buildDateTime(
        date ?? DateTime(2020, 1, 1),
        DateTime(
          2020,
          1,
          1,
          hour,
          minute,
          withSeconds ? second : 0,
        ),
      );

  /// Определяет, является ли дата сегодняшней
  bool isToday() => date() == DateTime.now().date();

  /// Форматирует дату в формате 2/3/2021
  String format() => DateFormat.yMd().format(this);
}

/// Дейт-ренж - класс с двумя дейт-таймами: дейт-тайм с, дейт-тайм по
@freezed
abstract class DateRange with _$DateRange {
  const DateRange._();

  /// Дейт-ренж - класс с двумя дейт-таймами: дейт-тайм с, дейт-тайм по
  factory DateRange(
    /// Дейт-тайм с
    DateTime from,

    /// Дейт-тайм по
    DateTime to,
  ) = _DateRange;

  /// Создает дейт-ренж из даты, времени с и времени по
  /// Если время с > времени по => дейт-ренж сквозной
  /// Например, дата - 2020-01-01, время с - 10:00, а время по - 02:00 =>
  /// дейт-ренж с 2020-01-01 10:00 по 2020-01-02 02:00
  factory DateRange.fromDateAndTimes(
          DateTime date, DateTime fromTime, DateTime toTime) =>
      DateRange(
        buildDateTime(date, fromTime),
        buildDateTime(
          date.add(Duration(days: fromTime.isAfter(toTime) ? 1 : 0)),
          toTime,
        ),
      );

  /// Находится ли {dateTime} в ренже
  bool containsDateTime(DateTime dateTime) =>
      (dateTime.isAfter(from) || dateTime.isAtSameMomentAs(from)) &&
      (dateTime.isBefore(to) || dateTime.isAtSameMomentAs(to));

  /// Дата дейт-ренжа
  DateTime get date => from.date();

  /// Создает дейт-ренж из дейт-тайма, времени с, времени по
  /// Например, дейт-тайм - 2020-01-02 01:00,
  ///   время с - 10:00, а время по - 02:00 =>
  /// дейт-ренж с 2020-01-01 10:00 по 2020-01-02 02:00 =>
  /// дейт-тайм относится к 2020-01-01, а не к 2020-01-02
  factory DateRange.fromDateTimeAndTimes(
    DateTime dateTime,
    DateTime fromTime,
    DateTime toTime,
  ) {
    var dateDateRange = DateRange.fromDateAndTimes(
      dateTime,
      fromTime,
      toTime,
    );
    var previousDateDateRange = DateRange.fromDateAndTimes(
      dateTime.add(Duration(days: -1)),
      fromTime,
      toTime,
    );

    return [dateDateRange, previousDateDateRange].firstWhere(
      (dr) => dr.containsDateTime(dateTime),
      orElse: () => dateDateRange,
    );
  }

  /// Создает дейтренж в ределах минуты
  factory DateRange.withinMinute(DateTime dateTimeWithoutSeconds) {
    return DateRange(
      DateTime(
        dateTimeWithoutSeconds.year,
        dateTimeWithoutSeconds.month,
        dateTimeWithoutSeconds.day,
        dateTimeWithoutSeconds.hour,
        dateTimeWithoutSeconds.minute,
      ),
      DateTime(
        dateTimeWithoutSeconds.year,
        dateTimeWithoutSeconds.month,
        dateTimeWithoutSeconds.day,
        dateTimeWithoutSeconds.hour,
        dateTimeWithoutSeconds.minute,
        59,
      ),
    );
  }
}
