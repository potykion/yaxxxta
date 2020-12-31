// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'view_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HabitProgressVMTearOff {
  const _$HabitProgressVMTearOff();

// ignore: unused_element
  _HabitProgressVM call({int id, String title, List<HabitRepeatVM> repeats}) {
    return _HabitProgressVM(
      id: id,
      title: title,
      repeats: repeats,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HabitProgressVM = _$HabitProgressVMTearOff();

/// @nodoc
mixin _$HabitProgressVM {
  int get id;

  /// Название
  String get title;

  /// Повторы (15 мин / раз 2 раза в день)
  List<HabitRepeatVM> get repeats;

  $HabitProgressVMCopyWith<HabitProgressVM> get copyWith;
}

/// @nodoc
abstract class $HabitProgressVMCopyWith<$Res> {
  factory $HabitProgressVMCopyWith(
          HabitProgressVM value, $Res Function(HabitProgressVM) then) =
      _$HabitProgressVMCopyWithImpl<$Res>;
  $Res call({int id, String title, List<HabitRepeatVM> repeats});
}

/// @nodoc
class _$HabitProgressVMCopyWithImpl<$Res>
    implements $HabitProgressVMCopyWith<$Res> {
  _$HabitProgressVMCopyWithImpl(this._value, this._then);

  final HabitProgressVM _value;
  // ignore: unused_field
  final $Res Function(HabitProgressVM) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object repeats = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      repeats:
          repeats == freezed ? _value.repeats : repeats as List<HabitRepeatVM>,
    ));
  }
}

/// @nodoc
abstract class _$HabitProgressVMCopyWith<$Res>
    implements $HabitProgressVMCopyWith<$Res> {
  factory _$HabitProgressVMCopyWith(
          _HabitProgressVM value, $Res Function(_HabitProgressVM) then) =
      __$HabitProgressVMCopyWithImpl<$Res>;
  @override
  $Res call({int id, String title, List<HabitRepeatVM> repeats});
}

/// @nodoc
class __$HabitProgressVMCopyWithImpl<$Res>
    extends _$HabitProgressVMCopyWithImpl<$Res>
    implements _$HabitProgressVMCopyWith<$Res> {
  __$HabitProgressVMCopyWithImpl(
      _HabitProgressVM _value, $Res Function(_HabitProgressVM) _then)
      : super(_value, (v) => _then(v as _HabitProgressVM));

  @override
  _HabitProgressVM get _value => super._value as _HabitProgressVM;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object repeats = freezed,
  }) {
    return _then(_HabitProgressVM(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      repeats:
          repeats == freezed ? _value.repeats : repeats as List<HabitRepeatVM>,
    ));
  }
}

/// @nodoc
class _$_HabitProgressVM extends _HabitProgressVM {
  _$_HabitProgressVM({this.id, this.title, this.repeats})
      : assert(repeats.length >= 1, 'Повторов должно быть >= 1'),
        super._();

  @override
  final int id;
  @override

  /// Название
  final String title;
  @override

  /// Повторы (15 мин / раз 2 раза в день)
  final List<HabitRepeatVM> repeats;

  @override
  String toString() {
    return 'HabitProgressVM(id: $id, title: $title, repeats: $repeats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitProgressVM &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.repeats, repeats) ||
                const DeepCollectionEquality().equals(other.repeats, repeats)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(repeats);

  @override
  _$HabitProgressVMCopyWith<_HabitProgressVM> get copyWith =>
      __$HabitProgressVMCopyWithImpl<_HabitProgressVM>(this, _$identity);
}

abstract class _HabitProgressVM extends HabitProgressVM {
  _HabitProgressVM._() : super._();
  factory _HabitProgressVM(
      {int id, String title, List<HabitRepeatVM> repeats}) = _$_HabitProgressVM;

  @override
  int get id;
  @override

  /// Название
  String get title;
  @override

  /// Повторы (15 мин / раз 2 раза в день)
  List<HabitRepeatVM> get repeats;
  @override
  _$HabitProgressVMCopyWith<_HabitProgressVM> get copyWith;
}

/// @nodoc
class _$HabitRepeatVMTearOff {
  const _$HabitRepeatVMTearOff();

// ignore: unused_element
  _HabitRepeatVM call(
      {double currentValue = 0,
      double goalValue,
      DateTime performTime,
      HabitType type}) {
    return _HabitRepeatVM(
      currentValue: currentValue,
      goalValue: goalValue,
      performTime: performTime,
      type: type,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HabitRepeatVM = _$HabitRepeatVMTearOff();

/// @nodoc
mixin _$HabitRepeatVM {
  /// Текущее значение (4 раза из 10)
  double get currentValue;

  /// Норматив (10 раз)
  double get goalValue;

  /// Время выполнения
  DateTime get performTime;

  /// Тип
  HabitType get type;

  $HabitRepeatVMCopyWith<HabitRepeatVM> get copyWith;
}

/// @nodoc
abstract class $HabitRepeatVMCopyWith<$Res> {
  factory $HabitRepeatVMCopyWith(
          HabitRepeatVM value, $Res Function(HabitRepeatVM) then) =
      _$HabitRepeatVMCopyWithImpl<$Res>;
  $Res call(
      {double currentValue,
      double goalValue,
      DateTime performTime,
      HabitType type});
}

/// @nodoc
class _$HabitRepeatVMCopyWithImpl<$Res>
    implements $HabitRepeatVMCopyWith<$Res> {
  _$HabitRepeatVMCopyWithImpl(this._value, this._then);

  final HabitRepeatVM _value;
  // ignore: unused_field
  final $Res Function(HabitRepeatVM) _then;

  @override
  $Res call({
    Object currentValue = freezed,
    Object goalValue = freezed,
    Object performTime = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      currentValue: currentValue == freezed
          ? _value.currentValue
          : currentValue as double,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      performTime:
          performTime == freezed ? _value.performTime : performTime as DateTime,
      type: type == freezed ? _value.type : type as HabitType,
    ));
  }
}

/// @nodoc
abstract class _$HabitRepeatVMCopyWith<$Res>
    implements $HabitRepeatVMCopyWith<$Res> {
  factory _$HabitRepeatVMCopyWith(
          _HabitRepeatVM value, $Res Function(_HabitRepeatVM) then) =
      __$HabitRepeatVMCopyWithImpl<$Res>;
  @override
  $Res call(
      {double currentValue,
      double goalValue,
      DateTime performTime,
      HabitType type});
}

/// @nodoc
class __$HabitRepeatVMCopyWithImpl<$Res>
    extends _$HabitRepeatVMCopyWithImpl<$Res>
    implements _$HabitRepeatVMCopyWith<$Res> {
  __$HabitRepeatVMCopyWithImpl(
      _HabitRepeatVM _value, $Res Function(_HabitRepeatVM) _then)
      : super(_value, (v) => _then(v as _HabitRepeatVM));

  @override
  _HabitRepeatVM get _value => super._value as _HabitRepeatVM;

  @override
  $Res call({
    Object currentValue = freezed,
    Object goalValue = freezed,
    Object performTime = freezed,
    Object type = freezed,
  }) {
    return _then(_HabitRepeatVM(
      currentValue: currentValue == freezed
          ? _value.currentValue
          : currentValue as double,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      performTime:
          performTime == freezed ? _value.performTime : performTime as DateTime,
      type: type == freezed ? _value.type : type as HabitType,
    ));
  }
}

/// @nodoc
class _$_HabitRepeatVM extends _HabitRepeatVM {
  _$_HabitRepeatVM(
      {this.currentValue = 0, this.goalValue, this.performTime, this.type})
      : assert(currentValue != null),
        super._();

  @JsonKey(defaultValue: 0)
  @override

  /// Текущее значение (4 раза из 10)
  final double currentValue;
  @override

  /// Норматив (10 раз)
  final double goalValue;
  @override

  /// Время выполнения
  final DateTime performTime;
  @override

  /// Тип
  final HabitType type;

  @override
  String toString() {
    return 'HabitRepeatVM(currentValue: $currentValue, goalValue: $goalValue, performTime: $performTime, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitRepeatVM &&
            (identical(other.currentValue, currentValue) ||
                const DeepCollectionEquality()
                    .equals(other.currentValue, currentValue)) &&
            (identical(other.goalValue, goalValue) ||
                const DeepCollectionEquality()
                    .equals(other.goalValue, goalValue)) &&
            (identical(other.performTime, performTime) ||
                const DeepCollectionEquality()
                    .equals(other.performTime, performTime)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentValue) ^
      const DeepCollectionEquality().hash(goalValue) ^
      const DeepCollectionEquality().hash(performTime) ^
      const DeepCollectionEquality().hash(type);

  @override
  _$HabitRepeatVMCopyWith<_HabitRepeatVM> get copyWith =>
      __$HabitRepeatVMCopyWithImpl<_HabitRepeatVM>(this, _$identity);
}

abstract class _HabitRepeatVM extends HabitRepeatVM {
  _HabitRepeatVM._() : super._();
  factory _HabitRepeatVM(
      {double currentValue,
      double goalValue,
      DateTime performTime,
      HabitType type}) = _$_HabitRepeatVM;

  @override

  /// Текущее значение (4 раза из 10)
  double get currentValue;
  @override

  /// Норматив (10 раз)
  double get goalValue;
  @override

  /// Время выполнения
  DateTime get performTime;
  @override

  /// Тип
  HabitType get type;
  @override
  _$HabitRepeatVMCopyWith<_HabitRepeatVM> get copyWith;
}
