// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PerformingPointTransaction _$PerformingPointTransactionFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'habitIncome':
      return HabitTransaction.fromJson(json);
    case 'rewardLoss':
      return RewardTransaction.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$PerformingPointTransactionTearOff {
  const _$PerformingPointTransactionTearOff();

  HabitTransaction habitIncome(
      {String? id,
      String? externalId,
      required DateTime created,
      int performingPoints = 1,
      String? userId,
      required String habitId}) {
    return HabitTransaction(
      id: id,
      externalId: externalId,
      created: created,
      performingPoints: performingPoints,
      userId: userId,
      habitId: habitId,
    );
  }

  RewardTransaction rewardLoss(
      {String? id,
      String? externalId,
      required DateTime created,
      required int performingPoints,
      String? userId,
      required String rewardId}) {
    return RewardTransaction(
      id: id,
      externalId: externalId,
      created: created,
      performingPoints: performingPoints,
      userId: userId,
      rewardId: rewardId,
    );
  }

  PerformingPointTransaction fromJson(Map<String, Object> json) {
    return PerformingPointTransaction.fromJson(json);
  }
}

/// @nodoc
const $PerformingPointTransaction = _$PerformingPointTransactionTearOff();

/// @nodoc
mixin _$PerformingPointTransaction {
  String? get id => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  int get performingPoints => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String habitId)
        habitIncome,
    required TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String rewardId)
        rewardLoss,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String habitId)?
        habitIncome,
    TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String rewardId)?
        rewardLoss,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HabitTransaction value) habitIncome,
    required TResult Function(RewardTransaction value) rewardLoss,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitTransaction value)? habitIncome,
    TResult Function(RewardTransaction value)? rewardLoss,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerformingPointTransactionCopyWith<PerformingPointTransaction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformingPointTransactionCopyWith<$Res> {
  factory $PerformingPointTransactionCopyWith(PerformingPointTransaction value,
          $Res Function(PerformingPointTransaction) then) =
      _$PerformingPointTransactionCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? externalId,
      DateTime created,
      int performingPoints,
      String? userId});
}

/// @nodoc
class _$PerformingPointTransactionCopyWithImpl<$Res>
    implements $PerformingPointTransactionCopyWith<$Res> {
  _$PerformingPointTransactionCopyWithImpl(this._value, this._then);

  final PerformingPointTransaction _value;
  // ignore: unused_field
  final $Res Function(PerformingPointTransaction) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? created = freezed,
    Object? performingPoints = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String?,
      externalId:
          externalId == freezed ? _value.externalId : externalId as String?,
      created: created == freezed ? _value.created : created as DateTime,
      performingPoints: performingPoints == freezed
          ? _value.performingPoints
          : performingPoints as int,
      userId: userId == freezed ? _value.userId : userId as String?,
    ));
  }
}

/// @nodoc
abstract class $HabitTransactionCopyWith<$Res>
    implements $PerformingPointTransactionCopyWith<$Res> {
  factory $HabitTransactionCopyWith(
          HabitTransaction value, $Res Function(HabitTransaction) then) =
      _$HabitTransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? externalId,
      DateTime created,
      int performingPoints,
      String? userId,
      String habitId});
}

/// @nodoc
class _$HabitTransactionCopyWithImpl<$Res>
    extends _$PerformingPointTransactionCopyWithImpl<$Res>
    implements $HabitTransactionCopyWith<$Res> {
  _$HabitTransactionCopyWithImpl(
      HabitTransaction _value, $Res Function(HabitTransaction) _then)
      : super(_value, (v) => _then(v as HabitTransaction));

  @override
  HabitTransaction get _value => super._value as HabitTransaction;

  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? created = freezed,
    Object? performingPoints = freezed,
    Object? userId = freezed,
    Object? habitId = freezed,
  }) {
    return _then(HabitTransaction(
      id: id == freezed ? _value.id : id as String?,
      externalId:
          externalId == freezed ? _value.externalId : externalId as String?,
      created: created == freezed ? _value.created : created as DateTime,
      performingPoints: performingPoints == freezed
          ? _value.performingPoints
          : performingPoints as int,
      userId: userId == freezed ? _value.userId : userId as String?,
      habitId: habitId == freezed ? _value.habitId : habitId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$HabitTransaction implements HabitTransaction {
  const _$HabitTransaction(
      {this.id,
      this.externalId,
      required this.created,
      this.performingPoints = 1,
      this.userId,
      required this.habitId});

  factory _$HabitTransaction.fromJson(Map<String, dynamic> json) =>
      _$_$HabitTransactionFromJson(json);

  @override
  final String? id;
  @override
  final String? externalId;
  @override
  final DateTime created;
  @JsonKey(defaultValue: 1)
  @override
  final int performingPoints;
  @override
  final String? userId;
  @override
  final String habitId;

  @override
  String toString() {
    return 'PerformingPointTransaction.habitIncome(id: $id, externalId: $externalId, created: $created, performingPoints: $performingPoints, userId: $userId, habitId: $habitId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HabitTransaction &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.externalId, externalId) ||
                const DeepCollectionEquality()
                    .equals(other.externalId, externalId)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.performingPoints, performingPoints) ||
                const DeepCollectionEquality()
                    .equals(other.performingPoints, performingPoints)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.habitId, habitId) ||
                const DeepCollectionEquality().equals(other.habitId, habitId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(externalId) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(performingPoints) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(habitId);

  @JsonKey(ignore: true)
  @override
  $HabitTransactionCopyWith<HabitTransaction> get copyWith =>
      _$HabitTransactionCopyWithImpl<HabitTransaction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String habitId)
        habitIncome,
    required TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String rewardId)
        rewardLoss,
  }) {
    return habitIncome(
        id, externalId, created, performingPoints, userId, habitId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String habitId)?
        habitIncome,
    TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String rewardId)?
        rewardLoss,
    required TResult orElse(),
  }) {
    if (habitIncome != null) {
      return habitIncome(
          id, externalId, created, performingPoints, userId, habitId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HabitTransaction value) habitIncome,
    required TResult Function(RewardTransaction value) rewardLoss,
  }) {
    return habitIncome(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitTransaction value)? habitIncome,
    TResult Function(RewardTransaction value)? rewardLoss,
    required TResult orElse(),
  }) {
    if (habitIncome != null) {
      return habitIncome(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$HabitTransactionToJson(this)..['runtimeType'] = 'habitIncome';
  }
}

abstract class HabitTransaction implements PerformingPointTransaction {
  const factory HabitTransaction(
      {String? id,
      String? externalId,
      required DateTime created,
      int performingPoints,
      String? userId,
      required String habitId}) = _$HabitTransaction;

  factory HabitTransaction.fromJson(Map<String, dynamic> json) =
      _$HabitTransaction.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get externalId => throw _privateConstructorUsedError;
  @override
  DateTime get created => throw _privateConstructorUsedError;
  @override
  int get performingPoints => throw _privateConstructorUsedError;
  @override
  String? get userId => throw _privateConstructorUsedError;
  String get habitId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $HabitTransactionCopyWith<HabitTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardTransactionCopyWith<$Res>
    implements $PerformingPointTransactionCopyWith<$Res> {
  factory $RewardTransactionCopyWith(
          RewardTransaction value, $Res Function(RewardTransaction) then) =
      _$RewardTransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? externalId,
      DateTime created,
      int performingPoints,
      String? userId,
      String rewardId});
}

/// @nodoc
class _$RewardTransactionCopyWithImpl<$Res>
    extends _$PerformingPointTransactionCopyWithImpl<$Res>
    implements $RewardTransactionCopyWith<$Res> {
  _$RewardTransactionCopyWithImpl(
      RewardTransaction _value, $Res Function(RewardTransaction) _then)
      : super(_value, (v) => _then(v as RewardTransaction));

  @override
  RewardTransaction get _value => super._value as RewardTransaction;

  @override
  $Res call({
    Object? id = freezed,
    Object? externalId = freezed,
    Object? created = freezed,
    Object? performingPoints = freezed,
    Object? userId = freezed,
    Object? rewardId = freezed,
  }) {
    return _then(RewardTransaction(
      id: id == freezed ? _value.id : id as String?,
      externalId:
          externalId == freezed ? _value.externalId : externalId as String?,
      created: created == freezed ? _value.created : created as DateTime,
      performingPoints: performingPoints == freezed
          ? _value.performingPoints
          : performingPoints as int,
      userId: userId == freezed ? _value.userId : userId as String?,
      rewardId: rewardId == freezed ? _value.rewardId : rewardId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$RewardTransaction implements RewardTransaction {
  const _$RewardTransaction(
      {this.id,
      this.externalId,
      required this.created,
      required this.performingPoints,
      this.userId,
      required this.rewardId});

  factory _$RewardTransaction.fromJson(Map<String, dynamic> json) =>
      _$_$RewardTransactionFromJson(json);

  @override
  final String? id;
  @override
  final String? externalId;
  @override
  final DateTime created;
  @override
  final int performingPoints;
  @override
  final String? userId;
  @override
  final String rewardId;

  @override
  String toString() {
    return 'PerformingPointTransaction.rewardLoss(id: $id, externalId: $externalId, created: $created, performingPoints: $performingPoints, userId: $userId, rewardId: $rewardId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RewardTransaction &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.externalId, externalId) ||
                const DeepCollectionEquality()
                    .equals(other.externalId, externalId)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.performingPoints, performingPoints) ||
                const DeepCollectionEquality()
                    .equals(other.performingPoints, performingPoints)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.rewardId, rewardId) ||
                const DeepCollectionEquality()
                    .equals(other.rewardId, rewardId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(externalId) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(performingPoints) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(rewardId);

  @JsonKey(ignore: true)
  @override
  $RewardTransactionCopyWith<RewardTransaction> get copyWith =>
      _$RewardTransactionCopyWithImpl<RewardTransaction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String habitId)
        habitIncome,
    required TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String rewardId)
        rewardLoss,
  }) {
    return rewardLoss(
        id, externalId, created, performingPoints, userId, rewardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String habitId)?
        habitIncome,
    TResult Function(String? id, String? externalId, DateTime created,
            int performingPoints, String? userId, String rewardId)?
        rewardLoss,
    required TResult orElse(),
  }) {
    if (rewardLoss != null) {
      return rewardLoss(
          id, externalId, created, performingPoints, userId, rewardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HabitTransaction value) habitIncome,
    required TResult Function(RewardTransaction value) rewardLoss,
  }) {
    return rewardLoss(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitTransaction value)? habitIncome,
    TResult Function(RewardTransaction value)? rewardLoss,
    required TResult orElse(),
  }) {
    if (rewardLoss != null) {
      return rewardLoss(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$RewardTransactionToJson(this)..['runtimeType'] = 'rewardLoss';
  }
}

abstract class RewardTransaction implements PerformingPointTransaction {
  const factory RewardTransaction(
      {String? id,
      String? externalId,
      required DateTime created,
      required int performingPoints,
      String? userId,
      required String rewardId}) = _$RewardTransaction;

  factory RewardTransaction.fromJson(Map<String, dynamic> json) =
      _$RewardTransaction.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get externalId => throw _privateConstructorUsedError;
  @override
  DateTime get created => throw _privateConstructorUsedError;
  @override
  int get performingPoints => throw _privateConstructorUsedError;
  @override
  String? get userId => throw _privateConstructorUsedError;
  String get rewardId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $RewardTransactionCopyWith<RewardTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
