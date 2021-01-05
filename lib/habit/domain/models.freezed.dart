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
      HabitDailyRepeatSettings dailyRepeatSettings,
      @required HabitPeriodSettings habitPeriod}) {
    return _Habit(
      id: id,
      created: created,
      title: title,
      type: type,
      goalValue: goalValue,
      dailyRepeatSettings: dailyRepeatSettings,
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
  String get id;

  /// Дата создания
  DateTime get created;

  /// Название
  String get title;

  /// Тип
  HabitType get type;

  /// Продолжительность / число повторений за раз
  double get goalValue;
  HabitDailyRepeatSettings get dailyRepeatSettings;

  /// Периодичность
  HabitPeriodSettings get habitPeriod;

  Map<String, dynamic> toJson();
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
      HabitDailyRepeatSettings dailyRepeatSettings,
      HabitPeriodSettings habitPeriod});

  $HabitDailyRepeatSettingsCopyWith<$Res> get dailyRepeatSettings;
  $HabitPeriodSettingsCopyWith<$Res> get habitPeriod;
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
    Object dailyRepeatSettings = freezed,
    Object habitPeriod = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      created: created == freezed ? _value.created : created as DateTime,
      title: title == freezed ? _value.title : title as String,
      type: type == freezed ? _value.type : type as HabitType,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      dailyRepeatSettings: dailyRepeatSettings == freezed
          ? _value.dailyRepeatSettings
          : dailyRepeatSettings as HabitDailyRepeatSettings,
      habitPeriod: habitPeriod == freezed
          ? _value.habitPeriod
          : habitPeriod as HabitPeriodSettings,
    ));
  }

  @override
  $HabitDailyRepeatSettingsCopyWith<$Res> get dailyRepeatSettings {
    if (_value.dailyRepeatSettings == null) {
      return null;
    }
    return $HabitDailyRepeatSettingsCopyWith<$Res>(_value.dailyRepeatSettings,
        (value) {
      return _then(_value.copyWith(dailyRepeatSettings: value));
    });
  }

  @override
  $HabitPeriodSettingsCopyWith<$Res> get habitPeriod {
    if (_value.habitPeriod == null) {
      return null;
    }
    return $HabitPeriodSettingsCopyWith<$Res>(_value.habitPeriod, (value) {
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
      {String id,
      DateTime created,
      String title,
      HabitType type,
      double goalValue,
      HabitDailyRepeatSettings dailyRepeatSettings,
      HabitPeriodSettings habitPeriod});

  @override
  $HabitDailyRepeatSettingsCopyWith<$Res> get dailyRepeatSettings;
  @override
  $HabitPeriodSettingsCopyWith<$Res> get habitPeriod;
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
    Object dailyRepeatSettings = freezed,
    Object habitPeriod = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed ? _value.id : id as String,
      created: created == freezed ? _value.created : created as DateTime,
      title: title == freezed ? _value.title : title as String,
      type: type == freezed ? _value.type : type as HabitType,
      goalValue: goalValue == freezed ? _value.goalValue : goalValue as double,
      dailyRepeatSettings: dailyRepeatSettings == freezed
          ? _value.dailyRepeatSettings
          : dailyRepeatSettings as HabitDailyRepeatSettings,
      habitPeriod: habitPeriod == freezed
          ? _value.habitPeriod
          : habitPeriod as HabitPeriodSettings,
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
      this.dailyRepeatSettings,
      @required this.habitPeriod})
      : assert(created != null),
        assert(title != null),
        assert(type != null),
        assert(goalValue != null),
        assert(habitPeriod != null),
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

  /// Продолжительность / число повторений за раз
  final double goalValue;
  @override
  final HabitDailyRepeatSettings dailyRepeatSettings;
  @override

  /// Периодичность
  final HabitPeriodSettings habitPeriod;

  @override
  String toString() {
    return 'Habit(id: $id, created: $created, title: $title, type: $type, goalValue: $goalValue, dailyRepeatSettings: $dailyRepeatSettings, habitPeriod: $habitPeriod)';
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
            (identical(other.dailyRepeatSettings, dailyRepeatSettings) ||
                const DeepCollectionEquality()
                    .equals(other.dailyRepeatSettings, dailyRepeatSettings)) &&
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
      const DeepCollectionEquality().hash(goalValue) ^
      const DeepCollectionEquality().hash(dailyRepeatSettings) ^
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
      {String id,
      @required DateTime created,
      String title,
      HabitType type,
      double goalValue,
      HabitDailyRepeatSettings dailyRepeatSettings,
      @required HabitPeriodSettings habitPeriod}) = _$_Habit;

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

  /// Продолжительность / число повторений за раз
  double get goalValue;
  @override
  HabitDailyRepeatSettings get dailyRepeatSettings;
  @override

  /// Периодичность
  HabitPeriodSettings get habitPeriod;
  @override
  _$HabitCopyWith<_Habit> get copyWith;
}

HabitPeriodSettings _$HabitPeriodSettingsFromJson(Map<String, dynamic> json) {
  return _HabitPeriodSettings.fromJson(json);
}

/// @nodoc
class _$HabitPeriodSettingsTearOff {
  const _$HabitPeriodSettingsTearOff();

// ignore: unused_element
  _HabitPeriodSettings call(
      {HabitPeriodType type = HabitPeriodType.day,
      int periodValue = 1,
      List<Weekday> weekdays = const <Weekday>[],
      int monthDay = 1,
      bool isCustom = false}) {
    return _HabitPeriodSettings(
      type: type,
      periodValue: periodValue,
      weekdays: weekdays,
      monthDay: monthDay,
      isCustom: isCustom,
    );
  }

// ignore: unused_element
  HabitPeriodSettings fromJson(Map<String, Object> json) {
    return HabitPeriodSettings.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $HabitPeriodSettings = _$HabitPeriodSettingsTearOff();

/// @nodoc
mixin _$HabitPeriodSettings {
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
  $HabitPeriodSettingsCopyWith<HabitPeriodSettings> get copyWith;
}

/// @nodoc
abstract class $HabitPeriodSettingsCopyWith<$Res> {
  factory $HabitPeriodSettingsCopyWith(
          HabitPeriodSettings value, $Res Function(HabitPeriodSettings) then) =
      _$HabitPeriodSettingsCopyWithImpl<$Res>;
  $Res call(
      {HabitPeriodType type,
      int periodValue,
      List<Weekday> weekdays,
      int monthDay,
      bool isCustom});
}

/// @nodoc
class _$HabitPeriodSettingsCopyWithImpl<$Res>
    implements $HabitPeriodSettingsCopyWith<$Res> {
  _$HabitPeriodSettingsCopyWithImpl(this._value, this._then);

  final HabitPeriodSettings _value;
  // ignore: unused_field
  final $Res Function(HabitPeriodSettings) _then;

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
abstract class _$HabitPeriodSettingsCopyWith<$Res>
    implements $HabitPeriodSettingsCopyWith<$Res> {
  factory _$HabitPeriodSettingsCopyWith(_HabitPeriodSettings value,
          $Res Function(_HabitPeriodSettings) then) =
      __$HabitPeriodSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {HabitPeriodType type,
      int periodValue,
      List<Weekday> weekdays,
      int monthDay,
      bool isCustom});
}

/// @nodoc
class __$HabitPeriodSettingsCopyWithImpl<$Res>
    extends _$HabitPeriodSettingsCopyWithImpl<$Res>
    implements _$HabitPeriodSettingsCopyWith<$Res> {
  __$HabitPeriodSettingsCopyWithImpl(
      _HabitPeriodSettings _value, $Res Function(_HabitPeriodSettings) _then)
      : super(_value, (v) => _then(v as _HabitPeriodSettings));

  @override
  _HabitPeriodSettings get _value => super._value as _HabitPeriodSettings;

  @override
  $Res call({
    Object type = freezed,
    Object periodValue = freezed,
    Object weekdays = freezed,
    Object monthDay = freezed,
    Object isCustom = freezed,
  }) {
    return _then(_HabitPeriodSettings(
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
class _$_HabitPeriodSettings implements _HabitPeriodSettings {
  const _$_HabitPeriodSettings(
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

  factory _$_HabitPeriodSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitPeriodSettingsFromJson(json);

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
    return 'HabitPeriodSettings(type: $type, periodValue: $periodValue, weekdays: $weekdays, monthDay: $monthDay, isCustom: $isCustom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitPeriodSettings &&
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
  _$HabitPeriodSettingsCopyWith<_HabitPeriodSettings> get copyWith =>
      __$HabitPeriodSettingsCopyWithImpl<_HabitPeriodSettings>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitPeriodSettingsToJson(this);
  }
}

abstract class _HabitPeriodSettings implements HabitPeriodSettings {
  const factory _HabitPeriodSettings(
      {HabitPeriodType type,
      int periodValue,
      List<Weekday> weekdays,
      int monthDay,
      bool isCustom}) = _$_HabitPeriodSettings;

  factory _HabitPeriodSettings.fromJson(Map<String, dynamic> json) =
      _$_HabitPeriodSettings.fromJson;

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
  _$HabitPeriodSettingsCopyWith<_HabitPeriodSettings> get copyWith;
}

HabitDailyRepeatSettings _$HabitDailyRepeatSettingsFromJson(
    Map<String, dynamic> json) {
  return _HabitDailyRepeatSettings.fromJson(json);
}

/// @nodoc
class _$HabitDailyRepeatSettingsTearOff {
  const _$HabitDailyRepeatSettingsTearOff();

// ignore: unused_element
  _HabitDailyRepeatSettings call(
      {bool repeatsEnabled = false,
      double repeatsCount = 1,
      Map<int, DateTime> performTimes = const <int, DateTime>{}}) {
    return _HabitDailyRepeatSettings(
      repeatsEnabled: repeatsEnabled,
      repeatsCount: repeatsCount,
      performTimes: performTimes,
    );
  }

// ignore: unused_element
  HabitDailyRepeatSettings fromJson(Map<String, Object> json) {
    return HabitDailyRepeatSettings.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $HabitDailyRepeatSettings = _$HabitDailyRepeatSettingsTearOff();

/// @nodoc
mixin _$HabitDailyRepeatSettings {
  /// Повторы в течение дня включены
  bool get repeatsEnabled;

  /// Число повторений за день
  double get repeatsCount;
  Map<int, DateTime> get performTimes;

  Map<String, dynamic> toJson();
  $HabitDailyRepeatSettingsCopyWith<HabitDailyRepeatSettings> get copyWith;
}

/// @nodoc
abstract class $HabitDailyRepeatSettingsCopyWith<$Res> {
  factory $HabitDailyRepeatSettingsCopyWith(HabitDailyRepeatSettings value,
          $Res Function(HabitDailyRepeatSettings) then) =
      _$HabitDailyRepeatSettingsCopyWithImpl<$Res>;
  $Res call(
      {bool repeatsEnabled,
      double repeatsCount,
      Map<int, DateTime> performTimes});
}

/// @nodoc
class _$HabitDailyRepeatSettingsCopyWithImpl<$Res>
    implements $HabitDailyRepeatSettingsCopyWith<$Res> {
  _$HabitDailyRepeatSettingsCopyWithImpl(this._value, this._then);

  final HabitDailyRepeatSettings _value;
  // ignore: unused_field
  final $Res Function(HabitDailyRepeatSettings) _then;

  @override
  $Res call({
    Object repeatsEnabled = freezed,
    Object repeatsCount = freezed,
    Object performTimes = freezed,
  }) {
    return _then(_value.copyWith(
      repeatsEnabled: repeatsEnabled == freezed
          ? _value.repeatsEnabled
          : repeatsEnabled as bool,
      repeatsCount: repeatsCount == freezed
          ? _value.repeatsCount
          : repeatsCount as double,
      performTimes: performTimes == freezed
          ? _value.performTimes
          : performTimes as Map<int, DateTime>,
    ));
  }
}

/// @nodoc
abstract class _$HabitDailyRepeatSettingsCopyWith<$Res>
    implements $HabitDailyRepeatSettingsCopyWith<$Res> {
  factory _$HabitDailyRepeatSettingsCopyWith(_HabitDailyRepeatSettings value,
          $Res Function(_HabitDailyRepeatSettings) then) =
      __$HabitDailyRepeatSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool repeatsEnabled,
      double repeatsCount,
      Map<int, DateTime> performTimes});
}

/// @nodoc
class __$HabitDailyRepeatSettingsCopyWithImpl<$Res>
    extends _$HabitDailyRepeatSettingsCopyWithImpl<$Res>
    implements _$HabitDailyRepeatSettingsCopyWith<$Res> {
  __$HabitDailyRepeatSettingsCopyWithImpl(_HabitDailyRepeatSettings _value,
      $Res Function(_HabitDailyRepeatSettings) _then)
      : super(_value, (v) => _then(v as _HabitDailyRepeatSettings));

  @override
  _HabitDailyRepeatSettings get _value =>
      super._value as _HabitDailyRepeatSettings;

  @override
  $Res call({
    Object repeatsEnabled = freezed,
    Object repeatsCount = freezed,
    Object performTimes = freezed,
  }) {
    return _then(_HabitDailyRepeatSettings(
      repeatsEnabled: repeatsEnabled == freezed
          ? _value.repeatsEnabled
          : repeatsEnabled as bool,
      repeatsCount: repeatsCount == freezed
          ? _value.repeatsCount
          : repeatsCount as double,
      performTimes: performTimes == freezed
          ? _value.performTimes
          : performTimes as Map<int, DateTime>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_HabitDailyRepeatSettings implements _HabitDailyRepeatSettings {
  const _$_HabitDailyRepeatSettings(
      {this.repeatsEnabled = false,
      this.repeatsCount = 1,
      this.performTimes = const <int, DateTime>{}})
      : assert(repeatsEnabled != null),
        assert(repeatsCount != null),
        assert(performTimes != null);

  factory _$_HabitDailyRepeatSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitDailyRepeatSettingsFromJson(json);

  @JsonKey(defaultValue: false)
  @override

  /// Повторы в течение дня включены
  final bool repeatsEnabled;
  @JsonKey(defaultValue: 1)
  @override

  /// Число повторений за день
  final double repeatsCount;
  @JsonKey(defaultValue: const <int, DateTime>{})
  @override
  final Map<int, DateTime> performTimes;

  @override
  String toString() {
    return 'HabitDailyRepeatSettings(repeatsEnabled: $repeatsEnabled, repeatsCount: $repeatsCount, performTimes: $performTimes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitDailyRepeatSettings &&
            (identical(other.repeatsEnabled, repeatsEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.repeatsEnabled, repeatsEnabled)) &&
            (identical(other.repeatsCount, repeatsCount) ||
                const DeepCollectionEquality()
                    .equals(other.repeatsCount, repeatsCount)) &&
            (identical(other.performTimes, performTimes) ||
                const DeepCollectionEquality()
                    .equals(other.performTimes, performTimes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(repeatsEnabled) ^
      const DeepCollectionEquality().hash(repeatsCount) ^
      const DeepCollectionEquality().hash(performTimes);

  @override
  _$HabitDailyRepeatSettingsCopyWith<_HabitDailyRepeatSettings> get copyWith =>
      __$HabitDailyRepeatSettingsCopyWithImpl<_HabitDailyRepeatSettings>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitDailyRepeatSettingsToJson(this);
  }
}

abstract class _HabitDailyRepeatSettings implements HabitDailyRepeatSettings {
  const factory _HabitDailyRepeatSettings(
      {bool repeatsEnabled,
      double repeatsCount,
      Map<int, DateTime> performTimes}) = _$_HabitDailyRepeatSettings;

  factory _HabitDailyRepeatSettings.fromJson(Map<String, dynamic> json) =
      _$_HabitDailyRepeatSettings.fromJson;

  @override

  /// Повторы в течение дня включены
  bool get repeatsEnabled;
  @override

  /// Число повторений за день
  double get repeatsCount;
  @override
  Map<int, DateTime> get performTimes;
  @override
  _$HabitDailyRepeatSettingsCopyWith<_HabitDailyRepeatSettings> get copyWith;
}

HabitPerforming _$HabitPerformingFromJson(Map<String, dynamic> json) {
  return _HabitPerforming.fromJson(json);
}

/// @nodoc
class _$HabitPerformingTearOff {
  const _$HabitPerformingTearOff();

// ignore: unused_element
  _HabitPerforming call(
      {@required String habitId,
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
  String get habitId;

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
      {String habitId,
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
      habitId: habitId == freezed ? _value.habitId : habitId as String,
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
      {String habitId,
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
      habitId: habitId == freezed ? _value.habitId : habitId as String,
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
  final String habitId;
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
      {@required String habitId,
      @required int repeatIndex,
      @required double performValue,
      @required DateTime performDateTime}) = _$_HabitPerforming;

  factory _HabitPerforming.fromJson(Map<String, dynamic> json) =
      _$_HabitPerforming.fromJson;

  @override

  /// Айди привычки
  String get habitId;
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
