// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'view_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HabitDetailsVMTearOff {
  const _$HabitDetailsVMTearOff();

// ignore: unused_element
  _HabitDetailsVM call(
      {@nullable Habit habit,
      @nullable List<HabitPerforming> habitPerformings}) {
    return _HabitDetailsVM(
      habit: habit,
      habitPerformings: habitPerformings,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HabitDetailsVM = _$HabitDetailsVMTearOff();

/// @nodoc
mixin _$HabitDetailsVM {
  @nullable
  Habit get habit;
  @nullable
  List<HabitPerforming> get habitPerformings;

  $HabitDetailsVMCopyWith<HabitDetailsPageVM> get copyWith;
}

/// @nodoc
abstract class $HabitDetailsVMCopyWith<$Res> {
  factory $HabitDetailsVMCopyWith(
          HabitDetailsPageVM value, $Res Function(HabitDetailsPageVM) then) =
      _$HabitDetailsVMCopyWithImpl<$Res>;
  $Res call(
      {@nullable Habit habit,
      @nullable List<HabitPerforming> habitPerformings});

  $HabitCopyWith<$Res> get habit;
}

/// @nodoc
class _$HabitDetailsVMCopyWithImpl<$Res>
    implements $HabitDetailsVMCopyWith<$Res> {
  _$HabitDetailsVMCopyWithImpl(this._value, this._then);

  final HabitDetailsPageVM _value;
  // ignore: unused_field
  final $Res Function(HabitDetailsPageVM) _then;

  @override
  $Res call({
    Object habit = freezed,
    Object habitPerformings = freezed,
  }) {
    return _then(_value.copyWith(
      habit: habit == freezed ? _value.habit : habit as Habit,
      habitPerformings: habitPerformings == freezed
          ? _value.habitPerformings
          : habitPerformings as List<HabitPerforming>,
    ));
  }

  @override
  $HabitCopyWith<$Res> get habit {
    if (_value.habit == null) {
      return null;
    }
    return $HabitCopyWith<$Res>(_value.habit, (value) {
      return _then(_value.copyWith(habit: value));
    });
  }
}

/// @nodoc
abstract class _$HabitDetailsVMCopyWith<$Res>
    implements $HabitDetailsVMCopyWith<$Res> {
  factory _$HabitDetailsVMCopyWith(
          _HabitDetailsVM value, $Res Function(_HabitDetailsVM) then) =
      __$HabitDetailsVMCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable Habit habit,
      @nullable List<HabitPerforming> habitPerformings});

  @override
  $HabitCopyWith<$Res> get habit;
}

/// @nodoc
class __$HabitDetailsVMCopyWithImpl<$Res>
    extends _$HabitDetailsVMCopyWithImpl<$Res>
    implements _$HabitDetailsVMCopyWith<$Res> {
  __$HabitDetailsVMCopyWithImpl(
      _HabitDetailsVM _value, $Res Function(_HabitDetailsVM) _then)
      : super(_value, (v) => _then(v as _HabitDetailsVM));

  @override
  _HabitDetailsVM get _value => super._value as _HabitDetailsVM;

  @override
  $Res call({
    Object habit = freezed,
    Object habitPerformings = freezed,
  }) {
    return _then(_HabitDetailsVM(
      habit: habit == freezed ? _value.habit : habit as Habit,
      habitPerformings: habitPerformings == freezed
          ? _value.habitPerformings
          : habitPerformings as List<HabitPerforming>,
    ));
  }
}

/// @nodoc
class _$_HabitDetailsVM extends _HabitDetailsVM {
  _$_HabitDetailsVM({@nullable this.habit, @nullable this.habitPerformings})
      : super._();

  @override
  @nullable
  final Habit habit;
  @override
  @nullable
  final List<HabitPerforming> habitPerformings;

  @override
  String toString() {
    return 'HabitDetailsVM(habit: $habit, habitPerformings: $habitPerformings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitDetailsVM &&
            (identical(other.habit, habit) ||
                const DeepCollectionEquality().equals(other.habit, habit)) &&
            (identical(other.habitPerformings, habitPerformings) ||
                const DeepCollectionEquality()
                    .equals(other.habitPerformings, habitPerformings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(habit) ^
      const DeepCollectionEquality().hash(habitPerformings);

  @override
  _$HabitDetailsVMCopyWith<_HabitDetailsVM> get copyWith =>
      __$HabitDetailsVMCopyWithImpl<_HabitDetailsVM>(this, _$identity);
}

abstract class _HabitDetailsVM extends HabitDetailsPageVM {
  _HabitDetailsVM._() : super._();
  factory _HabitDetailsVM(
      {@nullable Habit habit,
      @nullable List<HabitPerforming> habitPerformings}) = _$_HabitDetailsVM;

  @override
  @nullable
  Habit get habit;
  @override
  @nullable
  List<HabitPerforming> get habitPerformings;
  @override
  _$HabitDetailsVMCopyWith<_HabitDetailsVM> get copyWith;
}

/// @nodoc
class _$HabitHistoryEntryTearOff {
  const _$HabitHistoryEntryTearOff();

// ignore: unused_element
  _HabitHistoryEntry call({DateTime time, double value}) {
    return _HabitHistoryEntry(
      time: time,
      value: value,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HabitHistoryEntry = _$HabitHistoryEntryTearOff();

/// @nodoc
mixin _$HabitHistoryEntry {
  /// Время
  DateTime get time;

  /// Изменеие значения привычки
  double get value;

  $HabitHistoryEntryCopyWith<HabitHistoryEntry> get copyWith;
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
    Object time = freezed,
    Object value = freezed,
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
    Object time = freezed,
    Object value = freezed,
  }) {
    return _then(_HabitHistoryEntry(
      time: time == freezed ? _value.time : time as DateTime,
      value: value == freezed ? _value.value : value as double,
    ));
  }
}

/// @nodoc
class _$_HabitHistoryEntry extends _HabitHistoryEntry {
  _$_HabitHistoryEntry({this.time, this.value}) : super._();

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

  @override
  _$HabitHistoryEntryCopyWith<_HabitHistoryEntry> get copyWith =>
      __$HabitHistoryEntryCopyWithImpl<_HabitHistoryEntry>(this, _$identity);
}

abstract class _HabitHistoryEntry extends HabitHistoryEntry {
  _HabitHistoryEntry._() : super._();
  factory _HabitHistoryEntry({DateTime time, double value}) =
      _$_HabitHistoryEntry;

  @override

  /// Время
  DateTime get time;
  @override

  /// Изменеие значения привычки
  double get value;
  @override
  _$HabitHistoryEntryCopyWith<_HabitHistoryEntry> get copyWith;
}
