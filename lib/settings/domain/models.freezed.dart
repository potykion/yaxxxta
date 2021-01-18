// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return _Settings.fromJson(json);
}

/// @nodoc
class _$SettingsTearOff {
  const _$SettingsTearOff();

// ignore: unused_element
  _Settings call(
      {bool showCompleted = true, DateTime dayStartTime, DateTime dayEndTime}) {
    return _Settings(
      showCompleted: showCompleted,
      dayStartTime: dayStartTime,
      dayEndTime: dayEndTime,
    );
  }

// ignore: unused_element
  Settings fromJson(Map<String, Object> json) {
    return Settings.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Settings = _$SettingsTearOff();

/// @nodoc
mixin _$Settings {
  /// Показывать выполненные привычки
  bool get showCompleted;

  /// Начало дня
  DateTime get dayStartTime;

  /// Конец дня
  DateTime get dayEndTime;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res>;
  $Res call({bool showCompleted, DateTime dayStartTime, DateTime dayEndTime});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res> implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  final Settings _value;
  // ignore: unused_field
  final $Res Function(Settings) _then;

  @override
  $Res call({
    Object showCompleted = freezed,
    Object dayStartTime = freezed,
    Object dayEndTime = freezed,
  }) {
    return _then(_value.copyWith(
      showCompleted: showCompleted == freezed
          ? _value.showCompleted
          : showCompleted as bool,
      dayStartTime: dayStartTime == freezed
          ? _value.dayStartTime
          : dayStartTime as DateTime,
      dayEndTime:
          dayEndTime == freezed ? _value.dayEndTime : dayEndTime as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) then) =
      __$SettingsCopyWithImpl<$Res>;
  @override
  $Res call({bool showCompleted, DateTime dayStartTime, DateTime dayEndTime});
}

/// @nodoc
class __$SettingsCopyWithImpl<$Res> extends _$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(_Settings _value, $Res Function(_Settings) _then)
      : super(_value, (v) => _then(v as _Settings));

  @override
  _Settings get _value => super._value as _Settings;

  @override
  $Res call({
    Object showCompleted = freezed,
    Object dayStartTime = freezed,
    Object dayEndTime = freezed,
  }) {
    return _then(_Settings(
      showCompleted: showCompleted == freezed
          ? _value.showCompleted
          : showCompleted as bool,
      dayStartTime: dayStartTime == freezed
          ? _value.dayStartTime
          : dayStartTime as DateTime,
      dayEndTime:
          dayEndTime == freezed ? _value.dayEndTime : dayEndTime as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Settings implements _Settings {
  const _$_Settings(
      {this.showCompleted = true, this.dayStartTime, this.dayEndTime})
      : assert(showCompleted != null);

  factory _$_Settings.fromJson(Map<String, dynamic> json) =>
      _$_$_SettingsFromJson(json);

  @JsonKey(defaultValue: true)
  @override

  /// Показывать выполненные привычки
  final bool showCompleted;
  @override

  /// Начало дня
  final DateTime dayStartTime;
  @override

  /// Конец дня
  final DateTime dayEndTime;

  @override
  String toString() {
    return 'Settings(showCompleted: $showCompleted, dayStartTime: $dayStartTime, dayEndTime: $dayEndTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Settings &&
            (identical(other.showCompleted, showCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.showCompleted, showCompleted)) &&
            (identical(other.dayStartTime, dayStartTime) ||
                const DeepCollectionEquality()
                    .equals(other.dayStartTime, dayStartTime)) &&
            (identical(other.dayEndTime, dayEndTime) ||
                const DeepCollectionEquality()
                    .equals(other.dayEndTime, dayEndTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(showCompleted) ^
      const DeepCollectionEquality().hash(dayStartTime) ^
      const DeepCollectionEquality().hash(dayEndTime);

  @JsonKey(ignore: true)
  @override
  _$SettingsCopyWith<_Settings> get copyWith =>
      __$SettingsCopyWithImpl<_Settings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SettingsToJson(this);
  }
}

abstract class _Settings implements Settings {
  const factory _Settings(
      {bool showCompleted,
      DateTime dayStartTime,
      DateTime dayEndTime}) = _$_Settings;

  factory _Settings.fromJson(Map<String, dynamic> json) = _$_Settings.fromJson;

  @override

  /// Показывать выполненные привычки
  bool get showCompleted;
  @override

  /// Начало дня
  DateTime get dayStartTime;
  @override

  /// Конец дня
  DateTime get dayEndTime;
  @override
  @JsonKey(ignore: true)
  _$SettingsCopyWith<_Settings> get copyWith;
}
