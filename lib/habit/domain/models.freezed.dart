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
      {int id,
      @required DateTime created,
      String title = "",
      HabitType type = HabitType.time,
      bool dailyRepeatsEnabled = false,
      double goalValue = 1,
      double dailyRepeats = 1,
      @required HabitPeriod habitPeriod}) {
    return _Habit(
      id: id,
      created: created,
      title: title,
      type: type,
      dailyRepeatsEnabled: dailyRepeatsEnabled,
      goalValue: goalValue,
      dailyRepeats: dailyRepeats,
      habitPeriod: habitPeriod,
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
  int get id;

  /// Дата создания
  DateTime get created;

  /// Название
  String get title;

  /// Тип
  HabitType get type;

  /// Повторы в течение дня включены
  bool get dailyRepeatsEnabled;

  /// Продолжительность / число повторений за раз
  double get goalValue;

  /// Число повторений за день
  double get dailyRepeats;

  /// Периодичность
  HabitPeriod get habitPeriod;

  Map<String, dynamic> toJson();
  $HabitCopyWith<Habit> get copyWith;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res>;
  $Res call(
      {int id,
      DateTime created,
      String title,
      HabitType type,
      bool dailyRepeatsEnabled,
      double goalValue,
      double dailyRepeats,
      HabitPeriod habitPeriod});

  $HabitPeriodCopyWith<$Res> get habitPeriod;
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
    Object dailyRepeatsEnabled = freezed,
    Object goalValue = freezed,
    Object dailyRepeats = freezed,
    Object habitPeriod = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      created: created == freezed ? _value.created : created as DateTime,
      title: title == freezed ? _value.title : title as String,
      type: type == freezed ? _value.type : type as HabitType,
      dailyRepeatsEnabled: dailyRepeatsEnabled == freezed
          ? _value.dailyRepeatsEnabled
          : dailyRepeatsEnabled as bool,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      dailyRepeats: dailyRepeats == freezed
          ? _value.dailyRepeats
          : dailyRepeats as double,
      habitPeriod: habitPeriod == freezed
          ? _value.habitPeriod
          : habitPeriod as HabitPeriod,
    ));
  }

  @override
  $HabitPeriodCopyWith<$Res> get habitPeriod {
    if (_value.habitPeriod == null) {
      return null;
    }
    return $HabitPeriodCopyWith<$Res>(_value.habitPeriod, (value) {
      return _then(_value.copyWith(habitPeriod: value));
    });
  }
}

/// @nodoc
abstract class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) then) =
      __$HabitCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      DateTime created,
      String title,
      HabitType type,
      bool dailyRepeatsEnabled,
      double goalValue,
      double dailyRepeats,
      HabitPeriod habitPeriod});

  @override
  $HabitPeriodCopyWith<$Res> get habitPeriod;
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
    Object dailyRepeatsEnabled = freezed,
    Object goalValue = freezed,
    Object dailyRepeats = freezed,
    Object habitPeriod = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed ? _value.id : id as int,
      created: created == freezed ? _value.created : created as DateTime,
      title: title == freezed ? _value.title : title as String,
      type: type == freezed ? _value.type : type as HabitType,
      dailyRepeatsEnabled: dailyRepeatsEnabled == freezed
          ? _value.dailyRepeatsEnabled
          : dailyRepeatsEnabled as bool,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      dailyRepeats: dailyRepeats == freezed
          ? _value.dailyRepeats
          : dailyRepeats as double,
      habitPeriod: habitPeriod == freezed
          ? _value.habitPeriod
          : habitPeriod as HabitPeriod,
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
      this.type = HabitType.time,
      this.dailyRepeatsEnabled = false,
      this.goalValue = 1,
      this.dailyRepeats = 1,
      @required this.habitPeriod})
      : assert(created != null),
        assert(title != null),
        assert(type != null),
        assert(dailyRepeatsEnabled != null),
        assert(goalValue != null),
        assert(dailyRepeats != null),
        assert(habitPeriod != null),
        super._();

  factory _$_Habit.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitFromJson(json);

  @override

  /// Айдишник
  final int id;
  @override

  /// Дата создания
  final DateTime created;
  @JsonKey(defaultValue: "")
  @override

  /// Название
  final String title;
  @JsonKey(defaultValue: HabitType.time)
  @override

  /// Тип
  final HabitType type;
  @JsonKey(defaultValue: false)
  @override

  /// Повторы в течение дня включены
  final bool dailyRepeatsEnabled;
  @JsonKey(defaultValue: 1)
  @override

  /// Продолжительность / число повторений за раз
  final double goalValue;
  @JsonKey(defaultValue: 1)
  @override

  /// Число повторений за день
  final double dailyRepeats;
  @override

  /// Периодичность
  final HabitPeriod habitPeriod;

  @override
  String toString() {
    return 'Habit(id: $id, created: $created, title: $title, type: $type, dailyRepeatsEnabled: $dailyRepeatsEnabled, goalValue: $goalValue, dailyRepeats: $dailyRepeats, habitPeriod: $habitPeriod)';
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
            (identical(other.dailyRepeatsEnabled, dailyRepeatsEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.dailyRepeatsEnabled, dailyRepeatsEnabled)) &&
            (identical(other.goalValue, goalValue) ||
                const DeepCollectionEquality()
                    .equals(other.goalValue, goalValue)) &&
            (identical(other.dailyRepeats, dailyRepeats) ||
                const DeepCollectionEquality()
                    .equals(other.dailyRepeats, dailyRepeats)) &&
            (identical(other.habitPeriod, habitPeriod) ||
                const DeepCollectionEquality()
                    .equals(other.habitPeriod, habitPeriod)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(dailyRepeatsEnabled) ^
      const DeepCollectionEquality().hash(goalValue) ^
      const DeepCollectionEquality().hash(dailyRepeats) ^
      const DeepCollectionEquality().hash(habitPeriod);

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
      {int id,
      @required DateTime created,
      String title,
      HabitType type,
      bool dailyRepeatsEnabled,
      double goalValue,
      double dailyRepeats,
      @required HabitPeriod habitPeriod}) = _$_Habit;

  factory _Habit.fromJson(Map<String, dynamic> json) = _$_Habit.fromJson;

  @override

  /// Айдишник
  int get id;
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

  /// Повторы в течение дня включены
  bool get dailyRepeatsEnabled;
  @override

  /// Продолжительность / число повторений за раз
  double get goalValue;
  @override

  /// Число повторений за день
  double get dailyRepeats;
  @override

  /// Периодичность
  HabitPeriod get habitPeriod;
  @override
  _$HabitCopyWith<_Habit> get copyWith;
}

HabitPeriod _$HabitPeriodFromJson(Map<String, dynamic> json) {
  return _HabitPeriod.fromJson(json);
}

/// @nodoc
class _$HabitPeriodTearOff {
  const _$HabitPeriodTearOff();

// ignore: unused_element
  _HabitPeriod call(
      {HabitPeriodType type = HabitPeriodType.day,
      int periodValue = 1,
      List<Weekday> weekdays = const <Weekday>[],
      int monthDay = 1,
      bool isCustom = false}) {
    return _HabitPeriod(
      type: type,
      periodValue: periodValue,
      weekdays: weekdays,
      monthDay: monthDay,
      isCustom: isCustom,
    );
  }

// ignore: unused_element
  HabitPeriod fromJson(Map<String, Object> json) {
    return HabitPeriod.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $HabitPeriod = _$HabitPeriodTearOff();

/// @nodoc
mixin _$HabitPeriod {
  /// Тип периодичности
  HabitPeriodType get type;

  /// 1 раз в {periodValue} дней / недель / месяцев
  int get periodValue;

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  /// Аналог "Число повторений за день" для недель
  List<Weekday> get weekdays;

  /// [type=HabitPeriodType.month] День выполнения
  int get monthDay;

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  /// Вообще тупа в гуи юзается
  bool get isCustom;

  Map<String, dynamic> toJson();
  $HabitPeriodCopyWith<HabitPeriod> get copyWith;
}

/// @nodoc
abstract class $HabitPeriodCopyWith<$Res> {
  factory $HabitPeriodCopyWith(
          HabitPeriod value, $Res Function(HabitPeriod) then) =
      _$HabitPeriodCopyWithImpl<$Res>;
  $Res call(
      {HabitPeriodType type,
      int periodValue,
      List<Weekday> weekdays,
      int monthDay,
      bool isCustom});
}

/// @nodoc
class _$HabitPeriodCopyWithImpl<$Res> implements $HabitPeriodCopyWith<$Res> {
  _$HabitPeriodCopyWithImpl(this._value, this._then);

  final HabitPeriod _value;
  // ignore: unused_field
  final $Res Function(HabitPeriod) _then;

  @override
  $Res call({
    Object type = freezed,
    Object periodValue = freezed,
    Object weekdays = freezed,
    Object monthDay = freezed,
    Object isCustom = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as HabitPeriodType,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      weekdays:
          weekdays == freezed ? _value.weekdays : weekdays as List<Weekday>,
      monthDay: monthDay == freezed ? _value.monthDay : monthDay as int,
      isCustom: isCustom == freezed ? _value.isCustom : isCustom as bool,
    ));
  }
}

/// @nodoc
abstract class _$HabitPeriodCopyWith<$Res>
    implements $HabitPeriodCopyWith<$Res> {
  factory _$HabitPeriodCopyWith(
          _HabitPeriod value, $Res Function(_HabitPeriod) then) =
      __$HabitPeriodCopyWithImpl<$Res>;
  @override
  $Res call(
      {HabitPeriodType type,
      int periodValue,
      List<Weekday> weekdays,
      int monthDay,
      bool isCustom});
}

/// @nodoc
class __$HabitPeriodCopyWithImpl<$Res> extends _$HabitPeriodCopyWithImpl<$Res>
    implements _$HabitPeriodCopyWith<$Res> {
  __$HabitPeriodCopyWithImpl(
      _HabitPeriod _value, $Res Function(_HabitPeriod) _then)
      : super(_value, (v) => _then(v as _HabitPeriod));

  @override
  _HabitPeriod get _value => super._value as _HabitPeriod;

  @override
  $Res call({
    Object type = freezed,
    Object periodValue = freezed,
    Object weekdays = freezed,
    Object monthDay = freezed,
    Object isCustom = freezed,
  }) {
    return _then(_HabitPeriod(
      type: type == freezed ? _value.type : type as HabitPeriodType,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      weekdays:
          weekdays == freezed ? _value.weekdays : weekdays as List<Weekday>,
      monthDay: monthDay == freezed ? _value.monthDay : monthDay as int,
      isCustom: isCustom == freezed ? _value.isCustom : isCustom as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_HabitPeriod implements _HabitPeriod {
  const _$_HabitPeriod(
      {this.type = HabitPeriodType.day,
      this.periodValue = 1,
      this.weekdays = const <Weekday>[],
      this.monthDay = 1,
      this.isCustom = false})
      : assert(type != null),
        assert(periodValue != null),
        assert(weekdays != null),
        assert(monthDay != null),
        assert(isCustom != null);

  factory _$_HabitPeriod.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitPeriodFromJson(json);

  @JsonKey(defaultValue: HabitPeriodType.day)
  @override

  /// Тип периодичности
  final HabitPeriodType type;
  @JsonKey(defaultValue: 1)
  @override

  /// 1 раз в {periodValue} дней / недель / месяцев
  final int periodValue;
  @JsonKey(defaultValue: const <Weekday>[])
  @override

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  /// Аналог "Число повторений за день" для недель
  final List<Weekday> weekdays;
  @JsonKey(defaultValue: 1)
  @override

  /// [type=HabitPeriodType.month] День выполнения
  final int monthDay;
  @JsonKey(defaultValue: false)
  @override

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  /// Вообще тупа в гуи юзается
  final bool isCustom;

  @override
  String toString() {
    return 'HabitPeriod(type: $type, periodValue: $periodValue, weekdays: $weekdays, monthDay: $monthDay, isCustom: $isCustom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitPeriod &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.periodValue, periodValue) ||
                const DeepCollectionEquality()
                    .equals(other.periodValue, periodValue)) &&
            (identical(other.weekdays, weekdays) ||
                const DeepCollectionEquality()
                    .equals(other.weekdays, weekdays)) &&
            (identical(other.monthDay, monthDay) ||
                const DeepCollectionEquality()
                    .equals(other.monthDay, monthDay)) &&
            (identical(other.isCustom, isCustom) ||
                const DeepCollectionEquality()
                    .equals(other.isCustom, isCustom)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(periodValue) ^
      const DeepCollectionEquality().hash(weekdays) ^
      const DeepCollectionEquality().hash(monthDay) ^
      const DeepCollectionEquality().hash(isCustom);

  @override
  _$HabitPeriodCopyWith<_HabitPeriod> get copyWith =>
      __$HabitPeriodCopyWithImpl<_HabitPeriod>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitPeriodToJson(this);
  }
}

abstract class _HabitPeriod implements HabitPeriod {
  const factory _HabitPeriod(
      {HabitPeriodType type,
      int periodValue,
      List<Weekday> weekdays,
      int monthDay,
      bool isCustom}) = _$_HabitPeriod;

  factory _HabitPeriod.fromJson(Map<String, dynamic> json) =
      _$_HabitPeriod.fromJson;

  @override

  /// Тип периодичности
  HabitPeriodType get type;
  @override

  /// 1 раз в {periodValue} дней / недель / месяцев
  int get periodValue;
  @override

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  /// Аналог "Число повторений за день" для недель
  List<Weekday> get weekdays;
  @override

  /// [type=HabitPeriodType.month] День выполнения
  int get monthDay;
  @override

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  /// Вообще тупа в гуи юзается
  bool get isCustom;
  @override
  _$HabitPeriodCopyWith<_HabitPeriod> get copyWith;
}

HabitPerforming _$HabitPerformingFromJson(Map<String, dynamic> json) {
  return _HabitPerforming.fromJson(json);
}

/// @nodoc
class _$HabitPerformingTearOff {
  const _$HabitPerformingTearOff();

// ignore: unused_element
  _HabitPerforming call(
      {@required int habitId,
      @required int repeatIndex,
      @required double performValue,
      @required DateTime performDateTime}) {
    return _HabitPerforming(
      habitId: habitId,
      repeatIndex: repeatIndex,
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
  /// Айди привычки
  int get habitId;

  /// Раз выполнения (напр. 1 из 2)
  int get repeatIndex;

  /// Значение выполнения (напр. 10 сек)
  double get performValue;

  /// Время выполнения
  DateTime get performDateTime;

  Map<String, dynamic> toJson();
  $HabitPerformingCopyWith<HabitPerforming> get copyWith;
}

/// @nodoc
abstract class $HabitPerformingCopyWith<$Res> {
  factory $HabitPerformingCopyWith(
          HabitPerforming value, $Res Function(HabitPerforming) then) =
      _$HabitPerformingCopyWithImpl<$Res>;
  $Res call(
      {int habitId,
      int repeatIndex,
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
    Object habitId = freezed,
    Object repeatIndex = freezed,
    Object performValue = freezed,
    Object performDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      habitId: habitId == freezed ? _value.habitId : habitId as int,
      repeatIndex:
          repeatIndex == freezed ? _value.repeatIndex : repeatIndex as int,
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
      {int habitId,
      int repeatIndex,
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
    Object habitId = freezed,
    Object repeatIndex = freezed,
    Object performValue = freezed,
    Object performDateTime = freezed,
  }) {
    return _then(_HabitPerforming(
      habitId: habitId == freezed ? _value.habitId : habitId as int,
      repeatIndex:
          repeatIndex == freezed ? _value.repeatIndex : repeatIndex as int,
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
class _$_HabitPerforming implements _HabitPerforming {
  _$_HabitPerforming(
      {@required this.habitId,
      @required this.repeatIndex,
      @required this.performValue,
      @required this.performDateTime})
      : assert(habitId != null),
        assert(repeatIndex != null),
        assert(performValue != null),
        assert(performDateTime != null);

  factory _$_HabitPerforming.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitPerformingFromJson(json);

  @override

  /// Айди привычки
  final int habitId;
  @override

  /// Раз выполнения (напр. 1 из 2)
  final int repeatIndex;
  @override

  /// Значение выполнения (напр. 10 сек)
  final double performValue;
  @override

  /// Время выполнения
  final DateTime performDateTime;

  @override
  String toString() {
    return 'HabitPerforming(habitId: $habitId, repeatIndex: $repeatIndex, performValue: $performValue, performDateTime: $performDateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitPerforming &&
            (identical(other.habitId, habitId) ||
                const DeepCollectionEquality()
                    .equals(other.habitId, habitId)) &&
            (identical(other.repeatIndex, repeatIndex) ||
                const DeepCollectionEquality()
                    .equals(other.repeatIndex, repeatIndex)) &&
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
      const DeepCollectionEquality().hash(habitId) ^
      const DeepCollectionEquality().hash(repeatIndex) ^
      const DeepCollectionEquality().hash(performValue) ^
      const DeepCollectionEquality().hash(performDateTime);

  @override
  _$HabitPerformingCopyWith<_HabitPerforming> get copyWith =>
      __$HabitPerformingCopyWithImpl<_HabitPerforming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitPerformingToJson(this);
  }
}

abstract class _HabitPerforming implements HabitPerforming {
  factory _HabitPerforming(
      {@required int habitId,
      @required int repeatIndex,
      @required double performValue,
      @required DateTime performDateTime}) = _$_HabitPerforming;

  factory _HabitPerforming.fromJson(Map<String, dynamic> json) =
      _$_HabitPerforming.fromJson;

  @override

  /// Айди привычки
  int get habitId;
  @override

  /// Раз выполнения (напр. 1 из 2)
  int get repeatIndex;
  @override

  /// Значение выполнения (напр. 10 сек)
  double get performValue;
  @override

  /// Время выполнения
  DateTime get performDateTime;
  @override
  _$HabitPerformingCopyWith<_HabitPerforming> get copyWith;
}
