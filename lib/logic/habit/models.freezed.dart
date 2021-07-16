// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Habit _$HabitFromJson(Map<String, dynamic> json) {
  return _Habit.fromJson(json);
}

/// @nodoc
class _$HabitTearOff {
  const _$HabitTearOff();

  _Habit call(
      {String? id,
      required String title,
      required String userId,
      required int order,
      bool archived = false,
      HabitNotificationSettings? notification,
      HabitFrequencyType frequencyType = HabitFrequencyType.daily}) {
    return _Habit(
      id: id,
      title: title,
      userId: userId,
      order: order,
      archived: archived,
      notification: notification,
      frequencyType: frequencyType,
    );
  }

  Habit fromJson(Map<String, Object> json) {
    return Habit.fromJson(json);
  }
}

/// @nodoc
const $Habit = _$HabitTearOff();

/// @nodoc
mixin _$Habit {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  bool get archived => throw _privateConstructorUsedError;
  HabitNotificationSettings? get notification =>
      throw _privateConstructorUsedError;
  HabitFrequencyType get frequencyType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HabitCopyWith<Habit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String title,
      String userId,
      int order,
      bool archived,
      HabitNotificationSettings? notification,
      HabitFrequencyType frequencyType});

  $HabitNotificationSettingsCopyWith<$Res>? get notification;
}

/// @nodoc
class _$HabitCopyWithImpl<$Res> implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  final Habit _value;
  // ignore: unused_field
  final $Res Function(Habit) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? userId = freezed,
    Object? order = freezed,
    Object? archived = freezed,
    Object? notification = freezed,
    Object? frequencyType = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      archived: archived == freezed
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool,
      notification: notification == freezed
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as HabitNotificationSettings?,
      frequencyType: frequencyType == freezed
          ? _value.frequencyType
          : frequencyType // ignore: cast_nullable_to_non_nullable
              as HabitFrequencyType,
    ));
  }

  @override
  $HabitNotificationSettingsCopyWith<$Res>? get notification {
    if (_value.notification == null) {
      return null;
    }

    return $HabitNotificationSettingsCopyWith<$Res>(_value.notification!,
        (value) {
      return _then(_value.copyWith(notification: value));
    });
  }
}

/// @nodoc
abstract class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) then) =
      __$HabitCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String title,
      String userId,
      int order,
      bool archived,
      HabitNotificationSettings? notification,
      HabitFrequencyType frequencyType});

  @override
  $HabitNotificationSettingsCopyWith<$Res>? get notification;
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
    Object? id = freezed,
    Object? title = freezed,
    Object? userId = freezed,
    Object? order = freezed,
    Object? archived = freezed,
    Object? notification = freezed,
    Object? frequencyType = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      archived: archived == freezed
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool,
      notification: notification == freezed
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as HabitNotificationSettings?,
      frequencyType: frequencyType == freezed
          ? _value.frequencyType
          : frequencyType // ignore: cast_nullable_to_non_nullable
              as HabitFrequencyType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Habit extends _Habit {
  const _$_Habit(
      {this.id,
      required this.title,
      required this.userId,
      required this.order,
      this.archived = false,
      this.notification,
      this.frequencyType = HabitFrequencyType.daily})
      : super._();

  factory _$_Habit.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String userId;
  @override
  final int order;
  @JsonKey(defaultValue: false)
  @override
  final bool archived;
  @override
  final HabitNotificationSettings? notification;
  @JsonKey(defaultValue: HabitFrequencyType.daily)
  @override
  final HabitFrequencyType frequencyType;

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, userId: $userId, order: $order, archived: $archived, notification: $notification, frequencyType: $frequencyType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Habit &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.archived, archived) ||
                const DeepCollectionEquality()
                    .equals(other.archived, archived)) &&
            (identical(other.notification, notification) ||
                const DeepCollectionEquality()
                    .equals(other.notification, notification)) &&
            (identical(other.frequencyType, frequencyType) ||
                const DeepCollectionEquality()
                    .equals(other.frequencyType, frequencyType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(order) ^
      const DeepCollectionEquality().hash(archived) ^
      const DeepCollectionEquality().hash(notification) ^
      const DeepCollectionEquality().hash(frequencyType);

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
  const factory _Habit(
      {String? id,
      required String title,
      required String userId,
      required int order,
      bool archived,
      HabitNotificationSettings? notification,
      HabitFrequencyType frequencyType}) = _$_Habit;
  const _Habit._() : super._();

  factory _Habit.fromJson(Map<String, dynamic> json) = _$_Habit.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  int get order => throw _privateConstructorUsedError;
  @override
  bool get archived => throw _privateConstructorUsedError;
  @override
  HabitNotificationSettings? get notification =>
      throw _privateConstructorUsedError;
  @override
  HabitFrequencyType get frequencyType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HabitCopyWith<_Habit> get copyWith => throw _privateConstructorUsedError;
}

HabitNotificationSettings _$HabitNotificationSettingsFromJson(
    Map<String, dynamic> json) {
  return _HabitNotificationSettings.fromJson(json);
}

/// @nodoc
class _$HabitNotificationSettingsTearOff {
  const _$HabitNotificationSettingsTearOff();

  _HabitNotificationSettings call({required int id, required DateTime time}) {
    return _HabitNotificationSettings(
      id: id,
      time: time,
    );
  }

  HabitNotificationSettings fromJson(Map<String, Object> json) {
    return HabitNotificationSettings.fromJson(json);
  }
}

/// @nodoc
const $HabitNotificationSettings = _$HabitNotificationSettingsTearOff();

/// @nodoc
mixin _$HabitNotificationSettings {
  int get id => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HabitNotificationSettingsCopyWith<HabitNotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitNotificationSettingsCopyWith<$Res> {
  factory $HabitNotificationSettingsCopyWith(HabitNotificationSettings value,
          $Res Function(HabitNotificationSettings) then) =
      _$HabitNotificationSettingsCopyWithImpl<$Res>;
  $Res call({int id, DateTime time});
}

/// @nodoc
class _$HabitNotificationSettingsCopyWithImpl<$Res>
    implements $HabitNotificationSettingsCopyWith<$Res> {
  _$HabitNotificationSettingsCopyWithImpl(this._value, this._then);

  final HabitNotificationSettings _value;
  // ignore: unused_field
  final $Res Function(HabitNotificationSettings) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$HabitNotificationSettingsCopyWith<$Res>
    implements $HabitNotificationSettingsCopyWith<$Res> {
  factory _$HabitNotificationSettingsCopyWith(_HabitNotificationSettings value,
          $Res Function(_HabitNotificationSettings) then) =
      __$HabitNotificationSettingsCopyWithImpl<$Res>;
  @override
  $Res call({int id, DateTime time});
}

/// @nodoc
class __$HabitNotificationSettingsCopyWithImpl<$Res>
    extends _$HabitNotificationSettingsCopyWithImpl<$Res>
    implements _$HabitNotificationSettingsCopyWith<$Res> {
  __$HabitNotificationSettingsCopyWithImpl(_HabitNotificationSettings _value,
      $Res Function(_HabitNotificationSettings) _then)
      : super(_value, (v) => _then(v as _HabitNotificationSettings));

  @override
  _HabitNotificationSettings get _value =>
      super._value as _HabitNotificationSettings;

  @override
  $Res call({
    Object? id = freezed,
    Object? time = freezed,
  }) {
    return _then(_HabitNotificationSettings(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HabitNotificationSettings extends _HabitNotificationSettings {
  _$_HabitNotificationSettings({required this.id, required this.time})
      : super._();

  factory _$_HabitNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitNotificationSettingsFromJson(json);

  @override
  final int id;
  @override
  final DateTime time;

  @override
  String toString() {
    return 'HabitNotificationSettings(id: $id, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitNotificationSettings &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(time);

  @JsonKey(ignore: true)
  @override
  _$HabitNotificationSettingsCopyWith<_HabitNotificationSettings>
      get copyWith =>
          __$HabitNotificationSettingsCopyWithImpl<_HabitNotificationSettings>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitNotificationSettingsToJson(this);
  }
}

abstract class _HabitNotificationSettings extends HabitNotificationSettings {
  factory _HabitNotificationSettings(
      {required int id, required DateTime time}) = _$_HabitNotificationSettings;
  _HabitNotificationSettings._() : super._();

  factory _HabitNotificationSettings.fromJson(Map<String, dynamic> json) =
      _$_HabitNotificationSettings.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  DateTime get time => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HabitNotificationSettingsCopyWith<_HabitNotificationSettings>
      get copyWith => throw _privateConstructorUsedError;
}

HabitPerforming _$HabitPerformingFromJson(Map<String, dynamic> json) {
  return _HabitPerforming.fromJson(json);
}

/// @nodoc
class _$HabitPerformingTearOff {
  const _$HabitPerformingTearOff();

  _HabitPerforming call(
      {String? id,
      required DateTime created,
      required String habitId,
      required String userId}) {
    return _HabitPerforming(
      id: id,
      created: created,
      habitId: habitId,
      userId: userId,
    );
  }

  HabitPerforming fromJson(Map<String, Object> json) {
    return HabitPerforming.fromJson(json);
  }
}

/// @nodoc
const $HabitPerforming = _$HabitPerformingTearOff();

/// @nodoc
mixin _$HabitPerforming {
  String? get id => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  String get habitId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HabitPerformingCopyWith<HabitPerforming> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitPerformingCopyWith<$Res> {
  factory $HabitPerformingCopyWith(
          HabitPerforming value, $Res Function(HabitPerforming) then) =
      _$HabitPerformingCopyWithImpl<$Res>;
  $Res call({String? id, DateTime created, String habitId, String userId});
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
    Object? id = freezed,
    Object? created = freezed,
    Object? habitId = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      habitId: habitId == freezed
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({String? id, DateTime created, String habitId, String userId});
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
    Object? id = freezed,
    Object? created = freezed,
    Object? habitId = freezed,
    Object? userId = freezed,
  }) {
    return _then(_HabitPerforming(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      habitId: habitId == freezed
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HabitPerforming extends _HabitPerforming {
  const _$_HabitPerforming(
      {this.id,
      required this.created,
      required this.habitId,
      required this.userId})
      : super._();

  factory _$_HabitPerforming.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitPerformingFromJson(json);

  @override
  final String? id;
  @override
  final DateTime created;
  @override
  final String habitId;
  @override
  final String userId;

  @override
  String toString() {
    return 'HabitPerforming(id: $id, created: $created, habitId: $habitId, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitPerforming &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.habitId, habitId) ||
                const DeepCollectionEquality()
                    .equals(other.habitId, habitId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(habitId) ^
      const DeepCollectionEquality().hash(userId);

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
  const factory _HabitPerforming(
      {String? id,
      required DateTime created,
      required String habitId,
      required String userId}) = _$_HabitPerforming;
  const _HabitPerforming._() : super._();

  factory _HabitPerforming.fromJson(Map<String, dynamic> json) =
      _$_HabitPerforming.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  DateTime get created => throw _privateConstructorUsedError;
  @override
  String get habitId => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HabitPerformingCopyWith<_HabitPerforming> get copyWith =>
      throw _privateConstructorUsedError;
}
