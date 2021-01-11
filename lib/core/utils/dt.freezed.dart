// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'dt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DateRangeTearOff {
  const _$DateRangeTearOff();

// ignore: unused_element
  _DateRange call(DateTime from, DateTime to) {
    return _DateRange(
      from,
      to,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DateRange = _$DateRangeTearOff();

/// @nodoc
mixin _$DateRange {
  /// Дейт-тайм с
  DateTime get from;

  /// Дейт-тайм по
  DateTime get to;

  $DateRangeCopyWith<DateRange> get copyWith;
}

/// @nodoc
abstract class $DateRangeCopyWith<$Res> {
  factory $DateRangeCopyWith(DateRange value, $Res Function(DateRange) then) =
      _$DateRangeCopyWithImpl<$Res>;
  $Res call({DateTime from, DateTime to});
}

/// @nodoc
class _$DateRangeCopyWithImpl<$Res> implements $DateRangeCopyWith<$Res> {
  _$DateRangeCopyWithImpl(this._value, this._then);

  final DateRange _value;
  // ignore: unused_field
  final $Res Function(DateRange) _then;

  @override
  $Res call({
    Object from = freezed,
    Object to = freezed,
  }) {
    return _then(_value.copyWith(
      from: from == freezed ? _value.from : from as DateTime,
      to: to == freezed ? _value.to : to as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$DateRangeCopyWith<$Res> implements $DateRangeCopyWith<$Res> {
  factory _$DateRangeCopyWith(
          _DateRange value, $Res Function(_DateRange) then) =
      __$DateRangeCopyWithImpl<$Res>;
  @override
  $Res call({DateTime from, DateTime to});
}

/// @nodoc
class __$DateRangeCopyWithImpl<$Res> extends _$DateRangeCopyWithImpl<$Res>
    implements _$DateRangeCopyWith<$Res> {
  __$DateRangeCopyWithImpl(_DateRange _value, $Res Function(_DateRange) _then)
      : super(_value, (v) => _then(v as _DateRange));

  @override
  _DateRange get _value => super._value as _DateRange;

  @override
  $Res call({
    Object from = freezed,
    Object to = freezed,
  }) {
    return _then(_DateRange(
      from == freezed ? _value.from : from as DateTime,
      to == freezed ? _value.to : to as DateTime,
    ));
  }
}

/// @nodoc
class _$_DateRange extends _DateRange {
  _$_DateRange(this.from, this.to)
      : assert(from != null),
        assert(to != null),
        super._();

  @override

  /// Дейт-тайм с
  final DateTime from;
  @override

  /// Дейт-тайм по
  final DateTime to;

  @override
  String toString() {
    return 'DateRange(from: $from, to: $to)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DateRange &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to);

  @override
  _$DateRangeCopyWith<_DateRange> get copyWith =>
      __$DateRangeCopyWithImpl<_DateRange>(this, _$identity);
}

abstract class _DateRange extends DateRange {
  _DateRange._() : super._();
  factory _DateRange(DateTime from, DateTime to) = _$_DateRange;

  @override

  /// Дейт-тайм с
  DateTime get from;
  @override

  /// Дейт-тайм по
  DateTime get to;
  @override
  _$DateRangeCopyWith<_DateRange> get copyWith;
}
