// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LeaderboardEntry {
  int get rank => throw _privateConstructorUsedError;
  FriendId get memberId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get completedThisWeek => throw _privateConstructorUsedError;
  int get scheduledThisWeek => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntryCopyWith<$Res> {
  factory $LeaderboardEntryCopyWith(
    LeaderboardEntry value,
    $Res Function(LeaderboardEntry) then,
  ) = _$LeaderboardEntryCopyWithImpl<$Res, LeaderboardEntry>;
  @useResult
  $Res call({
    int rank,
    FriendId memberId,
    String displayName,
    String? avatarPath,
    int currentStreak,
    int completedThisWeek,
    int scheduledThisWeek,
  });
}

/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res, $Val extends LeaderboardEntry>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? memberId = null,
    Object? displayName = null,
    Object? avatarPath = freezed,
    Object? currentStreak = null,
    Object? completedThisWeek = null,
    Object? scheduledThisWeek = null,
  }) {
    return _then(
      _value.copyWith(
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            memberId: null == memberId
                ? _value.memberId
                : memberId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$LeaderboardEntryImplCopyWith<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  factory _$$LeaderboardEntryImplCopyWith(
    _$LeaderboardEntryImpl value,
    $Res Function(_$LeaderboardEntryImpl) then,
  ) = __$$LeaderboardEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int rank,
    FriendId memberId,
    String displayName,
    String? avatarPath,
    int currentStreak,
    int completedThisWeek,
    int scheduledThisWeek,
  });
}

/// @nodoc
class __$$LeaderboardEntryImplCopyWithImpl<$Res>
    extends _$LeaderboardEntryCopyWithImpl<$Res, _$LeaderboardEntryImpl>
    implements _$$LeaderboardEntryImplCopyWith<$Res> {
  __$$LeaderboardEntryImplCopyWithImpl(
    _$LeaderboardEntryImpl _value,
    $Res Function(_$LeaderboardEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? memberId = null,
    Object? displayName = null,
    Object? avatarPath = freezed,
    Object? currentStreak = null,
    Object? completedThisWeek = null,
    Object? scheduledThisWeek = null,
  }) {
    return _then(
      _$LeaderboardEntryImpl(
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        memberId: null == memberId
            ? _value.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
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

class _$LeaderboardEntryImpl implements _LeaderboardEntry {
  const _$LeaderboardEntryImpl({
    required this.rank,
    required this.memberId,
    required this.displayName,
    required this.avatarPath,
    required this.currentStreak,
    required this.completedThisWeek,
    required this.scheduledThisWeek,
  });

  @override
  final int rank;
  @override
  final FriendId memberId;
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
    return 'LeaderboardEntry(rank: $rank, memberId: $memberId, displayName: $displayName, avatarPath: $avatarPath, currentStreak: $currentStreak, completedThisWeek: $completedThisWeek, scheduledThisWeek: $scheduledThisWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntryImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
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
    rank,
    memberId,
    displayName,
    avatarPath,
    currentStreak,
    completedThisWeek,
    scheduledThisWeek,
  );

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      __$$LeaderboardEntryImplCopyWithImpl<_$LeaderboardEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _LeaderboardEntry implements LeaderboardEntry {
  const factory _LeaderboardEntry({
    required final int rank,
    required final FriendId memberId,
    required final String displayName,
    required final String? avatarPath,
    required final int currentStreak,
    required final int completedThisWeek,
    required final int scheduledThisWeek,
  }) = _$LeaderboardEntryImpl;

  @override
  int get rank;
  @override
  FriendId get memberId;
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

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
