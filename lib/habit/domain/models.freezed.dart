// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Habit _$HabitFromJson(Map<String, dynamic> json) {
  return _Habit.fromJson(json);
}

/// @nodoc
class _$HabitTearOff {
  const _$HabitTearOff();

// ignore: unused_element
  _Habit call(
      {String id,
      @required DateTime created,
      String title = "",
      HabitType type = HabitType.repeats,
      double goalValue = 1,
      DateTime performTime,
      HabitPeriodType periodType = HabitPeriodType.day,
      int periodValue = 1,
      List<Weekday> performWeekdays = const <Weekday>[],
      int performMonthDay = 1,
      bool isCustomPeriod = false,
      String deviceId,
      String userId}) {
    return _Habit(
      id: id,
      created: created,
      title: title,
      type: type,
      goalValue: goalValue,
      performTime: performTime,
      periodType: periodType,
      periodValue: periodValue,
      performWeekdays: performWeekdays,
      performMonthDay: performMonthDay,
      isCustomPeriod: isCustomPeriod,
      deviceId: deviceId,
      userId: userId,
    );
  }

// ignore: unused_element
  Habit fromJson(Map<String, Object> json) {
    return Habit.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Habit = _$HabitTearOff();

/// @nodoc
mixin _$Habit {
  /// Айдишник
  String get id;

  /// Дата создания
  DateTime get created;

  /// Название
  String get title;

  /// Тип
  HabitType get type;

  /// Продолжительность / число повторений
  double get goalValue;

  /// Время выполнения привычки
  DateTime get performTime;

  /// Тип периодичности
  HabitPeriodType get periodType;

  /// 1 раз в {periodValue} дней / недель / месяцев
  int get periodValue;

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  List<Weekday> get performWeekdays;

  /// [type=HabitPeriodType.month] День выполнения
  int get performMonthDay;

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  /// Вообще тупа в гуи юзается
  bool get isCustomPeriod;

  /// Айди девайса
  String get deviceId;

  /// Айди юзера
  String get userId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $HabitCopyWith<Habit> get copyWith;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res>;
  $Res call(
      {String id,
      DateTime created,
      String title,
      HabitType type,
      double goalValue,
      DateTime performTime,
      HabitPeriodType periodType,
      int periodValue,
      List<Weekday> performWeekdays,
      int performMonthDay,
      bool isCustomPeriod,
      String deviceId,
      String userId});
}

/// @nodoc
class _$HabitCopyWithImpl<$Res> implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  final Habit _value;
  // ignore: unused_field
  final $Res Function(Habit) _then;

  @override
  $Res call({
    Object id = freezed,
    Object created = freezed,
    Object title = freezed,
    Object type = freezed,
    Object goalValue = freezed,
    Object performTime = freezed,
    Object periodType = freezed,
    Object periodValue = freezed,
    Object performWeekdays = freezed,
    Object performMonthDay = freezed,
    Object isCustomPeriod = freezed,
    Object deviceId = freezed,
    Object userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      created: created == freezed ? _value.created : created as DateTime,
      title: title == freezed ? _value.title : title as String,
      type: type == freezed ? _value.type : type as HabitType,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      performTime:
          performTime == freezed ? _value.performTime : performTime as DateTime,
      periodType: periodType == freezed
          ? _value.periodType
          : periodType as HabitPeriodType,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      performWeekdays: performWeekdays == freezed
          ? _value.performWeekdays
          : performWeekdays as List<Weekday>,
      performMonthDay: performMonthDay == freezed
          ? _value.performMonthDay
          : performMonthDay as int,
      isCustomPeriod: isCustomPeriod == freezed
          ? _value.isCustomPeriod
          : isCustomPeriod as bool,
      deviceId: deviceId == freezed ? _value.deviceId : deviceId as String,
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

/// @nodoc
abstract class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) then) =
      __$HabitCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      DateTime created,
      String title,
      HabitType type,
      double goalValue,
      DateTime performTime,
      HabitPeriodType periodType,
      int periodValue,
      List<Weekday> performWeekdays,
      int performMonthDay,
      bool isCustomPeriod,
      String deviceId,
      String userId});
}

/// @nodoc
class __$HabitCopyWithImpl<$Res> extends _$HabitCopyWithImpl<$Res>
    implements _$HabitCopyWith<$Res> {
  __$HabitCopyWithImpl(_Habit _value, $Res Function(_Habit) _then)
      : super(_value, (v) => _then(v as _Habit));

  @override
  _Habit get _value => super._value as _Habit;

  @override
  $Res call({
    Object id = freezed,
    Object created = freezed,
    Object title = freezed,
    Object type = freezed,
    Object goalValue = freezed,
    Object performTime = freezed,
    Object periodType = freezed,
    Object periodValue = freezed,
    Object performWeekdays = freezed,
    Object performMonthDay = freezed,
    Object isCustomPeriod = freezed,
    Object deviceId = freezed,
    Object userId = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed ? _value.id : id as String,
      created: created == freezed ? _value.created : created as DateTime,
      title: title == freezed ? _value.title : title as String,
      type: type == freezed ? _value.type : type as HabitType,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      performTime:
          performTime == freezed ? _value.performTime : performTime as DateTime,
      periodType: periodType == freezed
          ? _value.periodType
          : periodType as HabitPeriodType,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      performWeekdays: performWeekdays == freezed
          ? _value.performWeekdays
          : performWeekdays as List<Weekday>,
      performMonthDay: performMonthDay == freezed
          ? _value.performMonthDay
          : performMonthDay as int,
      isCustomPeriod: isCustomPeriod == freezed
          ? _value.isCustomPeriod
          : isCustomPeriod as bool,
      deviceId: deviceId == freezed ? _value.deviceId : deviceId as String,
      userId: userId == freezed ? _value.userId : userId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Habit extends _Habit {
  const _$_Habit(
      {this.id,
      @required this.created,
      this.title = "",
      this.type = HabitType.repeats,
      this.goalValue = 1,
      this.performTime,
      this.periodType = HabitPeriodType.day,
      this.periodValue = 1,
      this.performWeekdays = const <Weekday>[],
      this.performMonthDay = 1,
      this.isCustomPeriod = false,
      this.deviceId,
      this.userId})
      : assert(created != null),
        assert(title != null),
        assert(type != null),
        assert(goalValue != null),
        assert(periodType != null),
        assert(periodValue != null),
        assert(performWeekdays != null),
        assert(performMonthDay != null),
        assert(isCustomPeriod != null),
        super._();

  factory _$_Habit.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitFromJson(json);

  @override

  /// Айдишник
  final String id;
  @override

  /// Дата создания
  final DateTime created;
  @JsonKey(defaultValue: "")
  @override

  /// Название
  final String title;
  @JsonKey(defaultValue: HabitType.repeats)
  @override

  /// Тип
  final HabitType type;
  @JsonKey(defaultValue: 1)
  @override

  /// Продолжительность / число повторений
  final double goalValue;
  @override

  /// Время выполнения привычки
  final DateTime performTime;
  @JsonKey(defaultValue: HabitPeriodType.day)
  @override

  /// Тип периодичности
  final HabitPeriodType periodType;
  @JsonKey(defaultValue: 1)
  @override

  /// 1 раз в {periodValue} дней / недель / месяцев
  final int periodValue;
  @JsonKey(defaultValue: const <Weekday>[])
  @override

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  final List<Weekday> performWeekdays;
  @JsonKey(defaultValue: 1)
  @override

  /// [type=HabitPeriodType.month] День выполнения
  final int performMonthDay;
  @JsonKey(defaultValue: false)
  @override

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  /// Вообще тупа в гуи юзается
  final bool isCustomPeriod;
  @override

  /// Айди девайса
  final String deviceId;
  @override

  /// Айди юзера
  final String userId;

  @override
  String toString() {
    return 'Habit(id: $id, created: $created, title: $title, type: $type, goalValue: $goalValue, performTime: $performTime, periodType: $periodType, periodValue: $periodValue, performWeekdays: $performWeekdays, performMonthDay: $performMonthDay, isCustomPeriod: $isCustomPeriod, deviceId: $deviceId, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Habit &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.goalValue, goalValue) ||
                const DeepCollectionEquality()
                    .equals(other.goalValue, goalValue)) &&
            (identical(other.performTime, performTime) ||
                const DeepCollectionEquality()
                    .equals(other.performTime, performTime)) &&
            (identical(other.periodType, periodType) ||
                const DeepCollectionEquality()
                    .equals(other.periodType, periodType)) &&
            (identical(other.periodValue, periodValue) ||
                const DeepCollectionEquality()
                    .equals(other.periodValue, periodValue)) &&
            (identical(other.performWeekdays, performWeekdays) ||
                const DeepCollectionEquality()
                    .equals(other.performWeekdays, performWeekdays)) &&
            (identical(other.performMonthDay, performMonthDay) ||
                const DeepCollectionEquality()
                    .equals(other.performMonthDay, performMonthDay)) &&
            (identical(other.isCustomPeriod, isCustomPeriod) ||
                const DeepCollectionEquality()
                    .equals(other.isCustomPeriod, isCustomPeriod)) &&
            (identical(other.deviceId, deviceId) ||
                const DeepCollectionEquality()
                    .equals(other.deviceId, deviceId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(goalValue) ^
      const DeepCollectionEquality().hash(performTime) ^
      const DeepCollectionEquality().hash(periodType) ^
      const DeepCollectionEquality().hash(periodValue) ^
      const DeepCollectionEquality().hash(performWeekdays) ^
      const DeepCollectionEquality().hash(performMonthDay) ^
      const DeepCollectionEquality().hash(isCustomPeriod) ^
      const DeepCollectionEquality().hash(deviceId) ^
      const DeepCollectionEquality().hash(userId);

  @JsonKey(ignore: true)
  @override
  _$HabitCopyWith<_Habit> get copyWith =>
      __$HabitCopyWithImpl<_Habit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitToJson(this);
  }
}

abstract class _Habit extends Habit {
  const _Habit._() : super._();
  const factory _Habit(
      {String id,
      @required DateTime created,
      String title,
      HabitType type,
      double goalValue,
      DateTime performTime,
      HabitPeriodType periodType,
      int periodValue,
      List<Weekday> performWeekdays,
      int performMonthDay,
      bool isCustomPeriod,
      String deviceId,
      String userId}) = _$_Habit;

  factory _Habit.fromJson(Map<String, dynamic> json) = _$_Habit.fromJson;

  @override

  /// Айдишник
  String get id;
  @override

  /// Дата создания
  DateTime get created;
  @override

  /// Название
  String get title;
  @override

  /// Тип
  HabitType get type;
  @override

  /// Продолжительность / число повторений
  double get goalValue;
  @override

  /// Время выполнения привычки
  DateTime get performTime;
  @override

  /// Тип периодичности
  HabitPeriodType get periodType;
  @override

  /// 1 раз в {periodValue} дней / недель / месяцев
  int get periodValue;
  @override

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  List<Weekday> get performWeekdays;
  @override

  /// [type=HabitPeriodType.month] День выполнения
  int get performMonthDay;
  @override

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  /// Вообще тупа в гуи юзается
  bool get isCustomPeriod;
  @override

  /// Айди девайса
  String get deviceId;
  @override

  /// Айди юзера
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$HabitCopyWith<_Habit> get copyWith;
}

HabitPerforming _$HabitPerformingFromJson(Map<String, dynamic> json) {
  return _HabitPerforming.fromJson(json);
}

/// @nodoc
class _$HabitPerformingTearOff {
  const _$HabitPerformingTearOff();

// ignore: unused_element
  _HabitPerforming call(
      {String id,
      @required String habitId,
      @required double performValue,
      @required DateTime performDateTime}) {
    return _HabitPerforming(
      id: id,
      habitId: habitId,
      performValue: performValue,
      performDateTime: performDateTime,
    );
  }

// ignore: unused_element
  HabitPerforming fromJson(Map<String, Object> json) {
    return HabitPerforming.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $HabitPerforming = _$HabitPerformingTearOff();

/// @nodoc
mixin _$HabitPerforming {
  /// Айди выполнения привычки
  String get id;

  /// Айди привычки
  String get habitId;

  /// Значение выполнения (напр. 10 сек)
  double get performValue;

  /// Время выполнения
  DateTime get performDateTime;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $HabitPerformingCopyWith<HabitPerforming> get copyWith;
}

/// @nodoc
abstract class $HabitPerformingCopyWith<$Res> {
  factory $HabitPerformingCopyWith(
          HabitPerforming value, $Res Function(HabitPerforming) then) =
      _$HabitPerformingCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String habitId,
      double performValue,
      DateTime performDateTime});
}

/// @nodoc
class _$HabitPerformingCopyWithImpl<$Res>
    implements $HabitPerformingCopyWith<$Res> {
  _$HabitPerformingCopyWithImpl(this._value, this._then);

  final HabitPerforming _value;
  // ignore: unused_field
  final $Res Function(HabitPerforming) _then;

  @override
  $Res call({
    Object id = freezed,
    Object habitId = freezed,
    Object performValue = freezed,
    Object performDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      habitId: habitId == freezed ? _value.habitId : habitId as String,
      performValue: performValue == freezed
          ? _value.performValue
          : performValue as double,
      performDateTime: performDateTime == freezed
          ? _value.performDateTime
          : performDateTime as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$HabitPerformingCopyWith<$Res>
    implements $HabitPerformingCopyWith<$Res> {
  factory _$HabitPerformingCopyWith(
          _HabitPerforming value, $Res Function(_HabitPerforming) then) =
      __$HabitPerformingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String habitId,
      double performValue,
      DateTime performDateTime});
}

/// @nodoc
class __$HabitPerformingCopyWithImpl<$Res>
    extends _$HabitPerformingCopyWithImpl<$Res>
    implements _$HabitPerformingCopyWith<$Res> {
  __$HabitPerformingCopyWithImpl(
      _HabitPerforming _value, $Res Function(_HabitPerforming) _then)
      : super(_value, (v) => _then(v as _HabitPerforming));

  @override
  _HabitPerforming get _value => super._value as _HabitPerforming;

  @override
  $Res call({
    Object id = freezed,
    Object habitId = freezed,
    Object performValue = freezed,
    Object performDateTime = freezed,
  }) {
    return _then(_HabitPerforming(
      id: id == freezed ? _value.id : id as String,
      habitId: habitId == freezed ? _value.habitId : habitId as String,
      performValue: performValue == freezed
          ? _value.performValue
          : performValue as double,
      performDateTime: performDateTime == freezed
          ? _value.performDateTime
          : performDateTime as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_HabitPerforming extends _HabitPerforming {
  _$_HabitPerforming(
      {this.id,
      @required this.habitId,
      @required this.performValue,
      @required this.performDateTime})
      : assert(habitId != null),
        assert(performValue != null),
        assert(performDateTime != null),
        super._();

  factory _$_HabitPerforming.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitPerformingFromJson(json);

  @override

  /// Айди выполнения привычки
  final String id;
  @override

  /// Айди привычки
  final String habitId;
  @override

  /// Значение выполнения (напр. 10 сек)
  final double performValue;
  @override

  /// Время выполнения
  final DateTime performDateTime;

  @override
  String toString() {
    return 'HabitPerforming(id: $id, habitId: $habitId, performValue: $performValue, performDateTime: $performDateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitPerforming &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.habitId, habitId) ||
                const DeepCollectionEquality()
                    .equals(other.habitId, habitId)) &&
            (identical(other.performValue, performValue) ||
                const DeepCollectionEquality()
                    .equals(other.performValue, performValue)) &&
            (identical(other.performDateTime, performDateTime) ||
                const DeepCollectionEquality()
                    .equals(other.performDateTime, performDateTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(habitId) ^
      const DeepCollectionEquality().hash(performValue) ^
      const DeepCollectionEquality().hash(performDateTime);

  @JsonKey(ignore: true)
  @override
  _$HabitPerformingCopyWith<_HabitPerforming> get copyWith =>
      __$HabitPerformingCopyWithImpl<_HabitPerforming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitPerformingToJson(this);
  }
}

abstract class _HabitPerforming extends HabitPerforming {
  _HabitPerforming._() : super._();
  factory _HabitPerforming(
      {String id,
      @required String habitId,
      @required double performValue,
      @required DateTime performDateTime}) = _$_HabitPerforming;

  factory _HabitPerforming.fromJson(Map<String, dynamic> json) =
      _$_HabitPerforming.fromJson;

  @override

  /// Айди выполнения привычки
  String get id;
  @override

  /// Айди привычки
  String get habitId;
  @override

  /// Значение выполнения (напр. 10 сек)
  double get performValue;
  @override

  /// Время выполнения
  DateTime get performDateTime;
  @override
  @JsonKey(ignore: true)
  _$HabitPerformingCopyWith<_HabitPerforming> get copyWith;
}
