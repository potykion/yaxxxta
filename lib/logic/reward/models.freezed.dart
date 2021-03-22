// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Reward _$RewardFromJson(Map<String, dynamic> json) {
  return _Reward.fromJson(json);
}

/// @nodoc
class _$RewardTearOff {
  const _$RewardTearOff();

  _Reward call(
      {String? id,
      required String title,
      required int cost,
      bool collected = false}) {
    return _Reward(
      id: id,
      title: title,
      cost: cost,
      collected: collected,
    );
  }

  Reward fromJson(Map<String, Object> json) {
    return Reward.fromJson(json);
  }
}

/// @nodoc
const $Reward = _$RewardTearOff();

/// @nodoc
mixin _$Reward {
  /// Айди
  String? get id => throw _privateConstructorUsedError;

  /// Название
  String get title => throw _privateConstructorUsedError;

  /// Стоимость
  /// Сколько баллов (performingPoints) нужно потратить,
  /// чтобы получить награду
  int get cost => throw _privateConstructorUsedError;

  /// Награда получена?
  bool get collected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RewardCopyWith<Reward> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardCopyWith<$Res> {
  factory $RewardCopyWith(Reward value, $Res Function(Reward) then) =
      _$RewardCopyWithImpl<$Res>;
  $Res call({String? id, String title, int cost, bool collected});
}

/// @nodoc
class _$RewardCopyWithImpl<$Res> implements $RewardCopyWith<$Res> {
  _$RewardCopyWithImpl(this._value, this._then);

  final Reward _value;
  // ignore: unused_field
  final $Res Function(Reward) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? cost = freezed,
    Object? collected = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String?,
      title: title == freezed ? _value.title : title as String,
      cost: cost == freezed ? _value.cost : cost as int,
      collected: collected == freezed ? _value.collected : collected as bool,
    ));
  }
}

/// @nodoc
abstract class _$RewardCopyWith<$Res> implements $RewardCopyWith<$Res> {
  factory _$RewardCopyWith(_Reward value, $Res Function(_Reward) then) =
      __$RewardCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String title, int cost, bool collected});
}

/// @nodoc
class __$RewardCopyWithImpl<$Res> extends _$RewardCopyWithImpl<$Res>
    implements _$RewardCopyWith<$Res> {
  __$RewardCopyWithImpl(_Reward _value, $Res Function(_Reward) _then)
      : super(_value, (v) => _then(v as _Reward));

  @override
  _Reward get _value => super._value as _Reward;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? cost = freezed,
    Object? collected = freezed,
  }) {
    return _then(_Reward(
      id: id == freezed ? _value.id : id as String?,
      title: title == freezed ? _value.title : title as String,
      cost: cost == freezed ? _value.cost : cost as int,
      collected: collected == freezed ? _value.collected : collected as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Reward extends _Reward {
  const _$_Reward(
      {this.id,
      required this.title,
      required this.cost,
      this.collected = false})
      : super._();

  factory _$_Reward.fromJson(Map<String, dynamic> json) =>
      _$_$_RewardFromJson(json);

  @override

  /// Айди
  final String? id;
  @override

  /// Название
  final String title;
  @override

  /// Стоимость
  /// Сколько баллов (performingPoints) нужно потратить,
  /// чтобы получить награду
  final int cost;
  @JsonKey(defaultValue: false)
  @override

  /// Награда получена?
  final bool collected;

  @override
  String toString() {
    return 'Reward(id: $id, title: $title, cost: $cost, collected: $collected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reward &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.cost, cost) ||
                const DeepCollectionEquality().equals(other.cost, cost)) &&
            (identical(other.collected, collected) ||
                const DeepCollectionEquality()
                    .equals(other.collected, collected)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(cost) ^
      const DeepCollectionEquality().hash(collected);

  @JsonKey(ignore: true)
  @override
  _$RewardCopyWith<_Reward> get copyWith =>
      __$RewardCopyWithImpl<_Reward>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RewardToJson(this);
  }
}

abstract class _Reward extends Reward {
  const _Reward._() : super._();
  const factory _Reward(
      {String? id,
      required String title,
      required int cost,
      bool collected}) = _$_Reward;

  factory _Reward.fromJson(Map<String, dynamic> json) = _$_Reward.fromJson;

  @override

  /// Айди
  String? get id => throw _privateConstructorUsedError;
  @override

  /// Название
  String get title => throw _privateConstructorUsedError;
  @override

  /// Стоимость
  /// Сколько баллов (performingPoints) нужно потратить,
  /// чтобы получить награду
  int get cost => throw _privateConstructorUsedError;
  @override

  /// Награда получена?
  bool get collected => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RewardCopyWith<_Reward> get copyWith => throw _privateConstructorUsedError;
}
