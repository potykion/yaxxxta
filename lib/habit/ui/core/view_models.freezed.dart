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
  _HabitProgressVM call(
      {String id,
      String title,
      double currentValue = 0,
      double goalValue,
      DateTime performTime,
      HabitType type}) {
    return _HabitProgressVM(
      id: id,
      title: title,
      currentValue: currentValue,
      goalValue: goalValue,
      performTime: performTime,
      type: type,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HabitProgressVM = _$HabitProgressVMTearOff();

/// @nodoc
mixin _$HabitProgressVM {
  String get id;

  /// Название
  String get title;

  /// Текущее значение (4 раза из 10)
  double get currentValue;

  /// Целевое значение (10 раз)
  double get goalValue;

  /// Время выполнения
  DateTime get performTime;

  /// Тип
  HabitType get type;

  @JsonKey(ignore: true)
  $HabitProgressVMCopyWith<HabitProgressVM> get copyWith;
}

/// @nodoc
abstract class $HabitProgressVMCopyWith<$Res> {
  factory $HabitProgressVMCopyWith(
          HabitProgressVM value, $Res Function(HabitProgressVM) then) =
      _$HabitProgressVMCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      double currentValue,
      double goalValue,
      DateTime performTime,
      HabitType type});
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
    Object currentValue = freezed,
    Object goalValue = freezed,
    Object performTime = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
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
abstract class _$HabitProgressVMCopyWith<$Res>
    implements $HabitProgressVMCopyWith<$Res> {
  factory _$HabitProgressVMCopyWith(
          _HabitProgressVM value, $Res Function(_HabitProgressVM) then) =
      __$HabitProgressVMCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      double currentValue,
      double goalValue,
      DateTime performTime,
      HabitType type});
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
    Object currentValue = freezed,
    Object goalValue = freezed,
    Object performTime = freezed,
    Object type = freezed,
  }) {
    return _then(_HabitProgressVM(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
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
class _$_HabitProgressVM extends _HabitProgressVM {
  _$_HabitProgressVM(
      {this.id,
      this.title,
      this.currentValue = 0,
      this.goalValue,
      this.performTime,
      this.type})
      : assert(currentValue != null),
        super._();

  @override
  final String id;
  @override

  /// Название
  final String title;
  @JsonKey(defaultValue: 0)
  @override

  /// Текущее значение (4 раза из 10)
  final double currentValue;
  @override

  /// Целевое значение (10 раз)
  final double goalValue;
  @override

  /// Время выполнения
  final DateTime performTime;
  @override

  /// Тип
  final HabitType type;

  @override
  String toString() {
    return 'HabitProgressVM(id: $id, title: $title, currentValue: $currentValue, goalValue: $goalValue, performTime: $performTime, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitProgressVM &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
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
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(currentValue) ^
      const DeepCollectionEquality().hash(goalValue) ^
      const DeepCollectionEquality().hash(performTime) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  _$HabitProgressVMCopyWith<_HabitProgressVM> get copyWith =>
      __$HabitProgressVMCopyWithImpl<_HabitProgressVM>(this, _$identity);
}

abstract class _HabitProgressVM extends HabitProgressVM {
  _HabitProgressVM._() : super._();
  factory _HabitProgressVM(
      {String id,
      String title,
      double currentValue,
      double goalValue,
      DateTime performTime,
      HabitType type}) = _$_HabitProgressVM;

  @override
  String get id;
  @override

  /// Название
  String get title;
  @override

  /// Текущее значение (4 раза из 10)
  double get currentValue;
  @override

  /// Целевое значение (10 раз)
  double get goalValue;
  @override

  /// Время выполнения
  DateTime get performTime;
  @override

  /// Тип
  HabitType get type;
  @override
  @JsonKey(ignore: true)
  _$HabitProgressVMCopyWith<_HabitProgressVM> get copyWith;
}
