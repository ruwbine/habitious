// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupMember {
  FriendId get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get completedThisWeek => throw _privateConstructorUsedError;
  int get scheduledThisWeek => throw _privateConstructorUsedError;

  /// Create a copy of GroupMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupMemberCopyWith<GroupMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMemberCopyWith<$Res> {
  factory $GroupMemberCopyWith(
    GroupMember value,
    $Res Function(GroupMember) then,
  ) = _$GroupMemberCopyWithImpl<$Res, GroupMember>;
  @useResult
  $Res call({
    FriendId id,
    String displayName,
    String? avatarPath,
    int currentStreak,
    int completedThisWeek,
    int scheduledThisWeek,
  });
}

/// @nodoc
class _$GroupMemberCopyWithImpl<$Res, $Val extends GroupMember>
    implements $GroupMemberCopyWith<$Res> {
  _$GroupMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? avatarPath = freezed,
    Object? currentStreak = null,
    Object? completedThisWeek = null,
    Object? scheduledThisWeek = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as FriendId,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarPath: freezed == avatarPath
                ? _value.avatarPath
                : avatarPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            completedThisWeek: null == completedThisWeek
                ? _value.completedThisWeek
                : completedThisWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduledThisWeek: null == scheduledThisWeek
                ? _value.scheduledThisWeek
                : scheduledThisWeek // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupMemberImplCopyWith<$Res>
    implements $GroupMemberCopyWith<$Res> {
  factory _$$GroupMemberImplCopyWith(
    _$GroupMemberImpl value,
    $Res Function(_$GroupMemberImpl) then,
  ) = __$$GroupMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FriendId id,
    String displayName,
    String? avatarPath,
    int currentStreak,
    int completedThisWeek,
    int scheduledThisWeek,
  });
}

/// @nodoc
class __$$GroupMemberImplCopyWithImpl<$Res>
    extends _$GroupMemberCopyWithImpl<$Res, _$GroupMemberImpl>
    implements _$$GroupMemberImplCopyWith<$Res> {
  __$$GroupMemberImplCopyWithImpl(
    _$GroupMemberImpl _value,
    $Res Function(_$GroupMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? avatarPath = freezed,
    Object? currentStreak = null,
    Object? completedThisWeek = null,
    Object? scheduledThisWeek = null,
  }) {
    return _then(
      _$GroupMemberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as FriendId,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarPath: freezed == avatarPath
            ? _value.avatarPath
            : avatarPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        completedThisWeek: null == completedThisWeek
            ? _value.completedThisWeek
            : completedThisWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduledThisWeek: null == scheduledThisWeek
            ? _value.scheduledThisWeek
            : scheduledThisWeek // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$GroupMemberImpl implements _GroupMember {
  const _$GroupMemberImpl({
    required this.id,
    required this.displayName,
    required this.avatarPath,
    required this.currentStreak,
    required this.completedThisWeek,
    required this.scheduledThisWeek,
  });

  @override
  final FriendId id;
  @override
  final String displayName;
  @override
  final String? avatarPath;
  @override
  final int currentStreak;
  @override
  final int completedThisWeek;
  @override
  final int scheduledThisWeek;

  @override
  String toString() {
    return 'GroupMember(id: $id, displayName: $displayName, avatarPath: $avatarPath, currentStreak: $currentStreak, completedThisWeek: $completedThisWeek, scheduledThisWeek: $scheduledThisWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarPath, avatarPath) ||
                other.avatarPath == avatarPath) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.completedThisWeek, completedThisWeek) ||
                other.completedThisWeek == completedThisWeek) &&
            (identical(other.scheduledThisWeek, scheduledThisWeek) ||
                other.scheduledThisWeek == scheduledThisWeek));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    displayName,
    avatarPath,
    currentStreak,
    completedThisWeek,
    scheduledThisWeek,
  );

  /// Create a copy of GroupMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMemberImplCopyWith<_$GroupMemberImpl> get copyWith =>
      __$$GroupMemberImplCopyWithImpl<_$GroupMemberImpl>(this, _$identity);
}

abstract class _GroupMember implements GroupMember {
  const factory _GroupMember({
    required final FriendId id,
    required final String displayName,
    required final String? avatarPath,
    required final int currentStreak,
    required final int completedThisWeek,
    required final int scheduledThisWeek,
  }) = _$GroupMemberImpl;

  @override
  FriendId get id;
  @override
  String get displayName;
  @override
  String? get avatarPath;
  @override
  int get currentStreak;
  @override
  int get completedThisWeek;
  @override
  int get scheduledThisWeek;

  /// Create a copy of GroupMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupMemberImplCopyWith<_$GroupMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Group {
  GroupId get id => throw _privateConstructorUsedError;
  HabitId get habitId => throw _privateConstructorUsedError;
  List<GroupMember> get members => throw _privateConstructorUsedError;
  int get completionPercentThisWeek => throw _privateConstructorUsedError;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call({
    GroupId id,
    HabitId habitId,
    List<GroupMember> members,
    int completionPercentThisWeek,
  });
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? habitId = null,
    Object? members = null,
    Object? completionPercentThisWeek = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as GroupId,
            habitId: null == habitId
                ? _value.habitId
                : habitId // ignore: cast_nullable_to_non_nullable
                      as HabitId,
            members: null == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<GroupMember>,
            completionPercentThisWeek: null == completionPercentThisWeek
                ? _value.completionPercentThisWeek
                : completionPercentThisWeek // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
    _$GroupImpl value,
    $Res Function(_$GroupImpl) then,
  ) = __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GroupId id,
    HabitId habitId,
    List<GroupMember> members,
    int completionPercentThisWeek,
  });
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
    _$GroupImpl _value,
    $Res Function(_$GroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? habitId = null,
    Object? members = null,
    Object? completionPercentThisWeek = null,
  }) {
    return _then(
      _$GroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as GroupId,
        habitId: null == habitId
            ? _value.habitId
            : habitId // ignore: cast_nullable_to_non_nullable
                  as HabitId,
        members: null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GroupMember>,
        completionPercentThisWeek: null == completionPercentThisWeek
            ? _value.completionPercentThisWeek
            : completionPercentThisWeek // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$GroupImpl implements _Group {
  const _$GroupImpl({
    required this.id,
    required this.habitId,
    required final List<GroupMember> members,
    required this.completionPercentThisWeek,
  }) : _members = members;

  @override
  final GroupId id;
  @override
  final HabitId habitId;
  final List<GroupMember> _members;
  @override
  List<GroupMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final int completionPercentThisWeek;

  @override
  String toString() {
    return 'Group(id: $id, habitId: $habitId, members: $members, completionPercentThisWeek: $completionPercentThisWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(
                  other.completionPercentThisWeek,
                  completionPercentThisWeek,
                ) ||
                other.completionPercentThisWeek == completionPercentThisWeek));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    habitId,
    const DeepCollectionEquality().hash(_members),
    completionPercentThisWeek,
  );

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);
}

abstract class _Group implements Group {
  const factory _Group({
    required final GroupId id,
    required final HabitId habitId,
    required final List<GroupMember> members,
    required final int completionPercentThisWeek,
  }) = _$GroupImpl;

  @override
  GroupId get id;
  @override
  HabitId get habitId;
  @override
  List<GroupMember> get members;
  @override
  int get completionPercentThisWeek;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
