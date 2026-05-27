// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HabitCompletion {
  HabitId get habitId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime get markedAt => throw _privateConstructorUsedError;

  /// Create a copy of HabitCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitCompletionCopyWith<HabitCompletion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitCompletionCopyWith<$Res> {
  factory $HabitCompletionCopyWith(
    HabitCompletion value,
    $Res Function(HabitCompletion) then,
  ) = _$HabitCompletionCopyWithImpl<$Res, HabitCompletion>;
  @useResult
  $Res call({HabitId habitId, DateTime date, DateTime markedAt});
}

/// @nodoc
class _$HabitCompletionCopyWithImpl<$Res, $Val extends HabitCompletion>
    implements $HabitCompletionCopyWith<$Res> {
  _$HabitCompletionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? date = null,
    Object? markedAt = null,
  }) {
    return _then(
      _value.copyWith(
            habitId: null == habitId
                ? _value.habitId
                : habitId // ignore: cast_nullable_to_non_nullable
                      as HabitId,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            markedAt: null == markedAt
                ? _value.markedAt
                : markedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HabitCompletionImplCopyWith<$Res>
    implements $HabitCompletionCopyWith<$Res> {
  factory _$$HabitCompletionImplCopyWith(
    _$HabitCompletionImpl value,
    $Res Function(_$HabitCompletionImpl) then,
  ) = __$$HabitCompletionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HabitId habitId, DateTime date, DateTime markedAt});
}

/// @nodoc
class __$$HabitCompletionImplCopyWithImpl<$Res>
    extends _$HabitCompletionCopyWithImpl<$Res, _$HabitCompletionImpl>
    implements _$$HabitCompletionImplCopyWith<$Res> {
  __$$HabitCompletionImplCopyWithImpl(
    _$HabitCompletionImpl _value,
    $Res Function(_$HabitCompletionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HabitCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? date = null,
    Object? markedAt = null,
  }) {
    return _then(
      _$HabitCompletionImpl(
        habitId: null == habitId
            ? _value.habitId
            : habitId // ignore: cast_nullable_to_non_nullable
                  as HabitId,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        markedAt: null == markedAt
            ? _value.markedAt
            : markedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$HabitCompletionImpl implements _HabitCompletion {
  const _$HabitCompletionImpl({
    required this.habitId,
    required this.date,
    required this.markedAt,
  });

  @override
  final HabitId habitId;
  @override
  final DateTime date;
  @override
  final DateTime markedAt;

  @override
  String toString() {
    return 'HabitCompletion(habitId: $habitId, date: $date, markedAt: $markedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitCompletionImpl &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.markedAt, markedAt) ||
                other.markedAt == markedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, habitId, date, markedAt);

  /// Create a copy of HabitCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitCompletionImplCopyWith<_$HabitCompletionImpl> get copyWith =>
      __$$HabitCompletionImplCopyWithImpl<_$HabitCompletionImpl>(
        this,
        _$identity,
      );
}

abstract class _HabitCompletion implements HabitCompletion {
  const factory _HabitCompletion({
    required final HabitId habitId,
    required final DateTime date,
    required final DateTime markedAt,
  }) = _$HabitCompletionImpl;

  @override
  HabitId get habitId;
  @override
  DateTime get date;
  @override
  DateTime get markedAt;

  /// Create a copy of HabitCompletion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitCompletionImplCopyWith<_$HabitCompletionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
