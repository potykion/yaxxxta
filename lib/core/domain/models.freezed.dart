// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DoubleDurationTearOff {
  const _$DoubleDurationTearOff();

// ignore: unused_element
  _DoubleDuration call(
      {double hours = 0, double minutes = 0, double seconds = 0}) {
    return _DoubleDuration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DoubleDuration = _$DoubleDurationTearOff();

/// @nodoc
mixin _$DoubleDuration {
  double get hours;
  double get minutes;
  double get seconds;

  @JsonKey(ignore: true)
  $DoubleDurationCopyWith<DoubleDuration> get copyWith;
}

/// @nodoc
abstract class $DoubleDurationCopyWith<$Res> {
  factory $DoubleDurationCopyWith(
          DoubleDuration value, $Res Function(DoubleDuration) then) =
      _$DoubleDurationCopyWithImpl<$Res>;
  $Res call({double hours, double minutes, double seconds});
}

/// @nodoc
class _$DoubleDurationCopyWithImpl<$Res>
    implements $DoubleDurationCopyWith<$Res> {
  _$DoubleDurationCopyWithImpl(this._value, this._then);

  final DoubleDuration _value;
  // ignore: unused_field
  final $Res Function(DoubleDuration) _then;

  @override
  $Res call({
    Object hours = freezed,
    Object minutes = freezed,
    Object seconds = freezed,
  }) {
    return _then(_value.copyWith(
      hours: hours == freezed ? _value.hours : hours as double,
      minutes: minutes == freezed ? _value.minutes : minutes as double,
      seconds: seconds == freezed ? _value.seconds : seconds as double,
    ));
  }
}

/// @nodoc
abstract class _$DoubleDurationCopyWith<$Res>
    implements $DoubleDurationCopyWith<$Res> {
  factory _$DoubleDurationCopyWith(
          _DoubleDuration value, $Res Function(_DoubleDuration) then) =
      __$DoubleDurationCopyWithImpl<$Res>;
  @override
  $Res call({double hours, double minutes, double seconds});
}

/// @nodoc
class __$DoubleDurationCopyWithImpl<$Res>
    extends _$DoubleDurationCopyWithImpl<$Res>
    implements _$DoubleDurationCopyWith<$Res> {
  __$DoubleDurationCopyWithImpl(
      _DoubleDuration _value, $Res Function(_DoubleDuration) _then)
      : super(_value, (v) => _then(v as _DoubleDuration));

  @override
  _DoubleDuration get _value => super._value as _DoubleDuration;

  @override
  $Res call({
    Object hours = freezed,
    Object minutes = freezed,
    Object seconds = freezed,
  }) {
    return _then(_DoubleDuration(
      hours: hours == freezed ? _value.hours : hours as double,
      minutes: minutes == freezed ? _value.minutes : minutes as double,
      seconds: seconds == freezed ? _value.seconds : seconds as double,
    ));
  }
}

/// @nodoc
class _$_DoubleDuration extends _DoubleDuration {
  const _$_DoubleDuration({this.hours = 0, this.minutes = 0, this.seconds = 0})
      : assert(hours != null),
        assert(minutes != null),
        assert(seconds != null),
        super._();

  @JsonKey(defaultValue: 0)
  @override
  final double hours;
  @JsonKey(defaultValue: 0)
  @override
  final double minutes;
  @JsonKey(defaultValue: 0)
  @override
  final double seconds;

  @override
  String toString() {
    return 'DoubleDuration(hours: $hours, minutes: $minutes, seconds: $seconds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DoubleDuration &&
            (identical(other.hours, hours) ||
                const DeepCollectionEquality().equals(other.hours, hours)) &&
            (identical(other.minutes, minutes) ||
                const DeepCollectionEquality()
                    .equals(other.minutes, minutes)) &&
            (identical(other.seconds, seconds) ||
                const DeepCollectionEquality().equals(other.seconds, seconds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(hours) ^
      const DeepCollectionEquality().hash(minutes) ^
      const DeepCollectionEquality().hash(seconds);

  @JsonKey(ignore: true)
  @override
  _$DoubleDurationCopyWith<_DoubleDuration> get copyWith =>
      __$DoubleDurationCopyWithImpl<_DoubleDuration>(this, _$identity);
}

abstract class _DoubleDuration extends DoubleDuration {
  const _DoubleDuration._() : super._();
  const factory _DoubleDuration(
      {double hours, double minutes, double seconds}) = _$_DoubleDuration;

  @override
  double get hours;
  @override
  double get minutes;
  @override
  double get seconds;
  @override
  @JsonKey(ignore: true)
  _$DoubleDurationCopyWith<_DoubleDuration> get copyWith;
}
