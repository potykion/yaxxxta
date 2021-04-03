// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HabitStats _$HabitStatsFromJson(Map<String, dynamic> json) {
  return _HabitStats.fromJson(json);
}

/// @nodoc
class _$HabitStatsTearOff {
  const _$HabitStatsTearOff();

  _HabitStats call(
      {int maxStrike = 0, int currentStrike = 0, DateTime? lastPerforming}) {
    return _HabitStats(
      maxStrike: maxStrike,
      currentStrike: currentStrike,
      lastPerforming: lastPerforming,
    );
  }

  HabitStats fromJson(Map<String, Object> json) {
    return HabitStats.fromJson(json);
  }
}

/// @nodoc
const $HabitStats = _$HabitStatsTearOff();

/// @nodoc
mixin _$HabitStats {
  int get maxStrike => throw _privateConstructorUsedError;
  int get currentStrike => throw _privateConstructorUsedError;
  DateTime? get lastPerforming => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HabitStatsCopyWith<HabitStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitStatsCopyWith<$Res> {
  factory $HabitStatsCopyWith(
          HabitStats value, $Res Function(HabitStats) then) =
      _$HabitStatsCopyWithImpl<$Res>;
  $Res call({int maxStrike, int currentStrike, DateTime? lastPerforming});
}

/// @nodoc
class _$HabitStatsCopyWithImpl<$Res> implements $HabitStatsCopyWith<$Res> {
  _$HabitStatsCopyWithImpl(this._value, this._then);

  final HabitStats _value;
  // ignore: unused_field
  final $Res Function(HabitStats) _then;

  @override
  $Res call({
    Object? maxStrike = freezed,
    Object? currentStrike = freezed,
    Object? lastPerforming = freezed,
  }) {
    return _then(_value.copyWith(
      maxStrike: maxStrike == freezed ? _value.maxStrike : maxStrike as int,
      currentStrike: currentStrike == freezed
          ? _value.currentStrike
          : currentStrike as int,
      lastPerforming: lastPerforming == freezed
          ? _value.lastPerforming
          : lastPerforming as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$HabitStatsCopyWith<$Res> implements $HabitStatsCopyWith<$Res> {
  factory _$HabitStatsCopyWith(
          _HabitStats value, $Res Function(_HabitStats) then) =
      __$HabitStatsCopyWithImpl<$Res>;
  @override
  $Res call({int maxStrike, int currentStrike, DateTime? lastPerforming});
}

/// @nodoc
class __$HabitStatsCopyWithImpl<$Res> extends _$HabitStatsCopyWithImpl<$Res>
    implements _$HabitStatsCopyWith<$Res> {
  __$HabitStatsCopyWithImpl(
      _HabitStats _value, $Res Function(_HabitStats) _then)
      : super(_value, (v) => _then(v as _HabitStats));

  @override
  _HabitStats get _value => super._value as _HabitStats;

  @override
  $Res call({
    Object? maxStrike = freezed,
    Object? currentStrike = freezed,
    Object? lastPerforming = freezed,
  }) {
    return _then(_HabitStats(
      maxStrike: maxStrike == freezed ? _value.maxStrike : maxStrike as int,
      currentStrike: currentStrike == freezed
          ? _value.currentStrike
          : currentStrike as int,
      lastPerforming: lastPerforming == freezed
          ? _value.lastPerforming
          : lastPerforming as DateTime?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_HabitStats extends _HabitStats {
  const _$_HabitStats(
      {this.maxStrike = 0, this.currentStrike = 0, this.lastPerforming})
      : super._();

  factory _$_HabitStats.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitStatsFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int maxStrike;
  @JsonKey(defaultValue: 0)
  @override
  final int currentStrike;
  @override
  final DateTime? lastPerforming;

  @override
  String toString() {
    return 'HabitStats(maxStrike: $maxStrike, currentStrike: $currentStrike, lastPerforming: $lastPerforming)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitStats &&
            (identical(other.maxStrike, maxStrike) ||
                const DeepCollectionEquality()
                    .equals(other.maxStrike, maxStrike)) &&
            (identical(other.currentStrike, currentStrike) ||
                const DeepCollectionEquality()
                    .equals(other.currentStrike, currentStrike)) &&
            (identical(other.lastPerforming, lastPerforming) ||
                const DeepCollectionEquality()
                    .equals(other.lastPerforming, lastPerforming)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(maxStrike) ^
      const DeepCollectionEquality().hash(currentStrike) ^
      const DeepCollectionEquality().hash(lastPerforming);

  @JsonKey(ignore: true)
  @override
  _$HabitStatsCopyWith<_HabitStats> get copyWith =>
      __$HabitStatsCopyWithImpl<_HabitStats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitStatsToJson(this);
  }
}

abstract class _HabitStats extends HabitStats {
  const _HabitStats._() : super._();
  const factory _HabitStats(
      {int maxStrike,
      int currentStrike,
      DateTime? lastPerforming}) = _$_HabitStats;

  factory _HabitStats.fromJson(Map<String, dynamic> json) =
      _$_HabitStats.fromJson;

  @override
  int get maxStrike => throw _privateConstructorUsedError;
  @override
  int get currentStrike => throw _privateConstructorUsedError;
  @override
  DateTime? get lastPerforming => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HabitStatsCopyWith<_HabitStats> get copyWith =>
      throw _privateConstructorUsedError;
}
