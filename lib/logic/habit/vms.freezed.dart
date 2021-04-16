// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'vms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HabitVMTearOff {
  const _$HabitVMTearOff();

  _HabitVM call(
      {required Habit habit,
      List<HabitPerforming> performings = const <HabitPerforming>[]}) {
    return _HabitVM(
      habit: habit,
      performings: performings,
    );
  }
}

/// @nodoc
const $HabitVM = _$HabitVMTearOff();

/// @nodoc
mixin _$HabitVM {
  Habit get habit => throw _privateConstructorUsedError;
  List<HabitPerforming> get performings => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HabitVMCopyWith<HabitVM> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitVMCopyWith<$Res> {
  factory $HabitVMCopyWith(HabitVM value, $Res Function(HabitVM) then) =
      _$HabitVMCopyWithImpl<$Res>;
  $Res call({Habit habit, List<HabitPerforming> performings});

  $HabitCopyWith<$Res> get habit;
}

/// @nodoc
class _$HabitVMCopyWithImpl<$Res> implements $HabitVMCopyWith<$Res> {
  _$HabitVMCopyWithImpl(this._value, this._then);

  final HabitVM _value;
  // ignore: unused_field
  final $Res Function(HabitVM) _then;

  @override
  $Res call({
    Object? habit = freezed,
    Object? performings = freezed,
  }) {
    return _then(_value.copyWith(
      habit: habit == freezed ? _value.habit : habit as Habit,
      performings: performings == freezed
          ? _value.performings
          : performings as List<HabitPerforming>,
    ));
  }

  @override
  $HabitCopyWith<$Res> get habit {
    return $HabitCopyWith<$Res>(_value.habit, (value) {
      return _then(_value.copyWith(habit: value));
    });
  }
}

/// @nodoc
abstract class _$HabitVMCopyWith<$Res> implements $HabitVMCopyWith<$Res> {
  factory _$HabitVMCopyWith(_HabitVM value, $Res Function(_HabitVM) then) =
      __$HabitVMCopyWithImpl<$Res>;
  @override
  $Res call({Habit habit, List<HabitPerforming> performings});

  @override
  $HabitCopyWith<$Res> get habit;
}

/// @nodoc
class __$HabitVMCopyWithImpl<$Res> extends _$HabitVMCopyWithImpl<$Res>
    implements _$HabitVMCopyWith<$Res> {
  __$HabitVMCopyWithImpl(_HabitVM _value, $Res Function(_HabitVM) _then)
      : super(_value, (v) => _then(v as _HabitVM));

  @override
  _HabitVM get _value => super._value as _HabitVM;

  @override
  $Res call({
    Object? habit = freezed,
    Object? performings = freezed,
  }) {
    return _then(_HabitVM(
      habit: habit == freezed ? _value.habit : habit as Habit,
      performings: performings == freezed
          ? _value.performings
          : performings as List<HabitPerforming>,
    ));
  }
}

/// @nodoc
class _$_HabitVM implements _HabitVM {
  const _$_HabitVM(
      {required this.habit, this.performings = const <HabitPerforming>[]});

  @override
  final Habit habit;
  @JsonKey(defaultValue: const <HabitPerforming>[])
  @override
  final List<HabitPerforming> performings;

  @override
  String toString() {
    return 'HabitVM(habit: $habit, performings: $performings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitVM &&
            (identical(other.habit, habit) ||
                const DeepCollectionEquality().equals(other.habit, habit)) &&
            (identical(other.performings, performings) ||
                const DeepCollectionEquality()
                    .equals(other.performings, performings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(habit) ^
      const DeepCollectionEquality().hash(performings);

  @JsonKey(ignore: true)
  @override
  _$HabitVMCopyWith<_HabitVM> get copyWith =>
      __$HabitVMCopyWithImpl<_HabitVM>(this, _$identity);
}

abstract class _HabitVM implements HabitVM {
  const factory _HabitVM(
      {required Habit habit, List<HabitPerforming> performings}) = _$_HabitVM;

  @override
  Habit get habit => throw _privateConstructorUsedError;
  @override
  List<HabitPerforming> get performings => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HabitVMCopyWith<_HabitVM> get copyWith =>
      throw _privateConstructorUsedError;
}
