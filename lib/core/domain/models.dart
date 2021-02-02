import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

@freezed
abstract class DoubleDuration implements _$DoubleDuration {
  const DoubleDuration._();

  const factory DoubleDuration({
    @Default(0) double hours,
    @Default(0) double minutes,
    @Default(0) double seconds,
  }) = _DoubleDuration;

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
}
