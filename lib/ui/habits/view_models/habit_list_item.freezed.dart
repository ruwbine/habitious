// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HabitListItem {
  Habit get habit => throw _privateConstructorUsedError;
  WeeklyProgress get progress => throw _privateConstructorUsedError;
  int get participantsCount => throw _privateConstructorUsedError;

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitListItemCopyWith<HabitListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitListItemCopyWith<$Res> {
  factory $HabitListItemCopyWith(
    HabitListItem value,
    $Res Function(HabitListItem) then,
  ) = _$HabitListItemCopyWithImpl<$Res, HabitListItem>;
  @useResult
  $Res call({Habit habit, WeeklyProgress progress, int participantsCount});

  $HabitCopyWith<$Res> get habit;
  $WeeklyProgressCopyWith<$Res> get progress;
}

/// @nodoc
class _$HabitListItemCopyWithImpl<$Res, $Val extends HabitListItem>
    implements $HabitListItemCopyWith<$Res> {
  _$HabitListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habit = null,
    Object? progress = null,
    Object? participantsCount = null,
  }) {
    return _then(
      _value.copyWith(
            habit: null == habit
                ? _value.habit
                : habit // ignore: cast_nullable_to_non_nullable
                      as Habit,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as WeeklyProgress,
            participantsCount: null == participantsCount
                ? _value.participantsCount
                : participantsCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HabitCopyWith<$Res> get habit {
    return $HabitCopyWith<$Res>(_value.habit, (value) {
      return _then(_value.copyWith(habit: value) as $Val);
    });
  }

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeeklyProgressCopyWith<$Res> get progress {
    return $WeeklyProgressCopyWith<$Res>(_value.progress, (value) {
      return _then(_value.copyWith(progress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HabitListItemImplCopyWith<$Res>
    implements $HabitListItemCopyWith<$Res> {
  factory _$$HabitListItemImplCopyWith(
    _$HabitListItemImpl value,
    $Res Function(_$HabitListItemImpl) then,
  ) = __$$HabitListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Habit habit, WeeklyProgress progress, int participantsCount});

  @override
  $HabitCopyWith<$Res> get habit;
  @override
  $WeeklyProgressCopyWith<$Res> get progress;
}

/// @nodoc
class __$$HabitListItemImplCopyWithImpl<$Res>
    extends _$HabitListItemCopyWithImpl<$Res, _$HabitListItemImpl>
    implements _$$HabitListItemImplCopyWith<$Res> {
  __$$HabitListItemImplCopyWithImpl(
    _$HabitListItemImpl _value,
    $Res Function(_$HabitListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habit = null,
    Object? progress = null,
    Object? participantsCount = null,
  }) {
    return _then(
      _$HabitListItemImpl(
        habit: null == habit
            ? _value.habit
            : habit // ignore: cast_nullable_to_non_nullable
                  as Habit,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as WeeklyProgress,
        participantsCount: null == participantsCount
            ? _value.participantsCount
            : participantsCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$HabitListItemImpl implements _HabitListItem {
  const _$HabitListItemImpl({
    required this.habit,
    required this.progress,
    required this.participantsCount,
  });

  @override
  final Habit habit;
  @override
  final WeeklyProgress progress;
  @override
  final int participantsCount;

  @override
  String toString() {
    return 'HabitListItem(habit: $habit, progress: $progress, participantsCount: $participantsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitListItemImpl &&
            (identical(other.habit, habit) || other.habit == habit) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.participantsCount, participantsCount) ||
                other.participantsCount == participantsCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, habit, progress, participantsCount);

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitListItemImplCopyWith<_$HabitListItemImpl> get copyWith =>
      __$$HabitListItemImplCopyWithImpl<_$HabitListItemImpl>(this, _$identity);
}

abstract class _HabitListItem implements HabitListItem {
  const factory _HabitListItem({
    required final Habit habit,
    required final WeeklyProgress progress,
    required final int participantsCount,
  }) = _$HabitListItemImpl;

  @override
  Habit get habit;
  @override
  WeeklyProgress get progress;
  @override
  int get participantsCount;

  /// Create a copy of HabitListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitListItemImplCopyWith<_$HabitListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
