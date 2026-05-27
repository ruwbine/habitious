// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Habit {
  HabitId get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  HabitColor get color => throw _privateConstructorUsedError;
  HabitIcon get icon => throw _privateConstructorUsedError;
  Set<Weekday> get schedule => throw _privateConstructorUsedError;
  ReminderTime? get reminder => throw _privateConstructorUsedError;
  HabitStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  GroupId? get groupId => throw _privateConstructorUsedError;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitCopyWith<Habit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res, Habit>;
  @useResult
  $Res call({
    HabitId id,
    String name,
    HabitColor color,
    HabitIcon icon,
    Set<Weekday> schedule,
    ReminderTime? reminder,
    HabitStatus status,
    DateTime createdAt,
    GroupId? groupId,
  });

  $ReminderTimeCopyWith<$Res>? get reminder;
}

/// @nodoc
class _$HabitCopyWithImpl<$Res, $Val extends Habit>
    implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? icon = null,
    Object? schedule = null,
    Object? reminder = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? groupId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as HabitId,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as HabitColor,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as HabitIcon,
            schedule: null == schedule
                ? _value.schedule
                : schedule // ignore: cast_nullable_to_non_nullable
                      as Set<Weekday>,
            reminder: freezed == reminder
                ? _value.reminder
                : reminder // ignore: cast_nullable_to_non_nullable
                      as ReminderTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as HabitStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            groupId: freezed == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as GroupId?,
          )
          as $Val,
    );
  }

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReminderTimeCopyWith<$Res>? get reminder {
    if (_value.reminder == null) {
      return null;
    }

    return $ReminderTimeCopyWith<$Res>(_value.reminder!, (value) {
      return _then(_value.copyWith(reminder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HabitImplCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$$HabitImplCopyWith(
    _$HabitImpl value,
    $Res Function(_$HabitImpl) then,
  ) = __$$HabitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    HabitId id,
    String name,
    HabitColor color,
    HabitIcon icon,
    Set<Weekday> schedule,
    ReminderTime? reminder,
    HabitStatus status,
    DateTime createdAt,
    GroupId? groupId,
  });

  @override
  $ReminderTimeCopyWith<$Res>? get reminder;
}

/// @nodoc
class __$$HabitImplCopyWithImpl<$Res>
    extends _$HabitCopyWithImpl<$Res, _$HabitImpl>
    implements _$$HabitImplCopyWith<$Res> {
  __$$HabitImplCopyWithImpl(
    _$HabitImpl _value,
    $Res Function(_$HabitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? icon = null,
    Object? schedule = null,
    Object? reminder = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? groupId = freezed,
  }) {
    return _then(
      _$HabitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as HabitId,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as HabitColor,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as HabitIcon,
        schedule: null == schedule
            ? _value._schedule
            : schedule // ignore: cast_nullable_to_non_nullable
                  as Set<Weekday>,
        reminder: freezed == reminder
            ? _value.reminder
            : reminder // ignore: cast_nullable_to_non_nullable
                  as ReminderTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as HabitStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        groupId: freezed == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as GroupId?,
      ),
    );
  }
}

/// @nodoc

class _$HabitImpl implements _Habit {
  const _$HabitImpl({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required final Set<Weekday> schedule,
    required this.reminder,
    required this.status,
    required this.createdAt,
    required this.groupId,
  }) : _schedule = schedule;

  @override
  final HabitId id;
  @override
  final String name;
  @override
  final HabitColor color;
  @override
  final HabitIcon icon;
  final Set<Weekday> _schedule;
  @override
  Set<Weekday> get schedule {
    if (_schedule is EqualUnmodifiableSetView) return _schedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_schedule);
  }

  @override
  final ReminderTime? reminder;
  @override
  final HabitStatus status;
  @override
  final DateTime createdAt;
  @override
  final GroupId? groupId;

  @override
  String toString() {
    return 'Habit(id: $id, name: $name, color: $color, icon: $icon, schedule: $schedule, reminder: $reminder, status: $status, createdAt: $createdAt, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._schedule, _schedule) &&
            (identical(other.reminder, reminder) ||
                other.reminder == reminder) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    color,
    icon,
    const DeepCollectionEquality().hash(_schedule),
    reminder,
    status,
    createdAt,
    groupId,
  );

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitImplCopyWith<_$HabitImpl> get copyWith =>
      __$$HabitImplCopyWithImpl<_$HabitImpl>(this, _$identity);
}

abstract class _Habit implements Habit {
  const factory _Habit({
    required final HabitId id,
    required final String name,
    required final HabitColor color,
    required final HabitIcon icon,
    required final Set<Weekday> schedule,
    required final ReminderTime? reminder,
    required final HabitStatus status,
    required final DateTime createdAt,
    required final GroupId? groupId,
  }) = _$HabitImpl;

  @override
  HabitId get id;
  @override
  String get name;
  @override
  HabitColor get color;
  @override
  HabitIcon get icon;
  @override
  Set<Weekday> get schedule;
  @override
  ReminderTime? get reminder;
  @override
  HabitStatus get status;
  @override
  DateTime get createdAt;
  @override
  GroupId? get groupId;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitImplCopyWith<_$HabitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
