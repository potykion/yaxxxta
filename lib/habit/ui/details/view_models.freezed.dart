// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'view_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HabitHistoryEntryTearOff {
  const _$HabitHistoryEntryTearOff();

  _HabitHistoryEntry call({required DateTime time, required double value}) {
    return _HabitHistoryEntry(
      time: time,
      value: value,
    );
  }
}

/// @nodoc
const $HabitHistoryEntry = _$HabitHistoryEntryTearOff();

/// @nodoc
mixin _$HabitHistoryEntry {
  /// Время
  DateTime get time => throw _privateConstructorUsedError;

  /// Изменеие значения привычки
  double get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HabitHistoryEntryCopyWith<HabitHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitHistoryEntryCopyWith<$Res> {
  factory $HabitHistoryEntryCopyWith(
          HabitHistoryEntry value, $Res Function(HabitHistoryEntry) then) =
      _$HabitHistoryEntryCopyWithImpl<$Res>;
  $Res call({DateTime time, double value});
}

/// @nodoc
class _$HabitHistoryEntryCopyWithImpl<$Res>
    implements $HabitHistoryEntryCopyWith<$Res> {
  _$HabitHistoryEntryCopyWithImpl(this._value, this._then);

  final HabitHistoryEntry _value;
  // ignore: unused_field
  final $Res Function(HabitHistoryEntry) _then;

  @override
  $Res call({
    Object? time = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      time: time == freezed ? _value.time : time as DateTime,
      value: value == freezed ? _value.value : value as double,
    ));
  }
}

/// @nodoc
abstract class _$HabitHistoryEntryCopyWith<$Res>
    implements $HabitHistoryEntryCopyWith<$Res> {
  factory _$HabitHistoryEntryCopyWith(
          _HabitHistoryEntry value, $Res Function(_HabitHistoryEntry) then) =
      __$HabitHistoryEntryCopyWithImpl<$Res>;
  @override
  $Res call({DateTime time, double value});
}

/// @nodoc
class __$HabitHistoryEntryCopyWithImpl<$Res>
    extends _$HabitHistoryEntryCopyWithImpl<$Res>
    implements _$HabitHistoryEntryCopyWith<$Res> {
  __$HabitHistoryEntryCopyWithImpl(
      _HabitHistoryEntry _value, $Res Function(_HabitHistoryEntry) _then)
      : super(_value, (v) => _then(v as _HabitHistoryEntry));

  @override
  _HabitHistoryEntry get _value => super._value as _HabitHistoryEntry;

  @override
  $Res call({
    Object? time = freezed,
    Object? value = freezed,
  }) {
    return _then(_HabitHistoryEntry(
      time: time == freezed ? _value.time : time as DateTime,
      value: value == freezed ? _value.value : value as double,
    ));
  }
}

/// @nodoc
class _$_HabitHistoryEntry extends _HabitHistoryEntry {
  _$_HabitHistoryEntry({required this.time, required this.value}) : super._();

  @override

  /// Время
  final DateTime time;
  @override

  /// Изменеие значения привычки
  final double value;

  @override
  String toString() {
    return 'HabitHistoryEntry(time: $time, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitHistoryEntry &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$HabitHistoryEntryCopyWith<_HabitHistoryEntry> get copyWith =>
      __$HabitHistoryEntryCopyWithImpl<_HabitHistoryEntry>(this, _$identity);
}

abstract class _HabitHistoryEntry extends HabitHistoryEntry {
  _HabitHistoryEntry._() : super._();
  factory _HabitHistoryEntry({required DateTime time, required double value}) =
      _$_HabitHistoryEntry;

  @override

  /// Время
  DateTime get time => throw _privateConstructorUsedError;
  @override

  /// Изменеие значения привычки
  double get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HabitHistoryEntryCopyWith<_HabitHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
