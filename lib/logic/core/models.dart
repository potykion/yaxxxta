import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

/// Длительность с возможностью использовать double
@freezed
abstract class DoubleDuration implements _$DoubleDuration {
  const DoubleDuration._();

  /// Длительность с возможностью использовать double
  const factory DoubleDuration({
    @Default(0) double hours,
    @Default(0) double minutes,
    @Default(0) double seconds,
  }) = _DoubleDuration;

  /// Создает длительность из секунд
  factory DoubleDuration.fromSeconds(double seconds) {
    var hours = (seconds / 3600).floorToDouble();
    var minutes = ((seconds - hours * 3600) / 60).floorToDouble();
    var remainingSeconds = seconds - hours * 3600 - minutes * 60;

    return DoubleDuration(
      hours: hours,
      minutes: minutes,
      seconds: remainingSeconds,
    );
  }

  /// Конвертит длительность в секунды
  double get asSeconds => seconds + minutes * 60 + hours * 3600;
}

/// Сущность с айди
mixin WithId {
  /// Айди
  String? get id;
}
