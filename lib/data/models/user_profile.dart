import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'theme_preference.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String displayName,
    required String? avatarPath,
    required int level,
    required int xp,
    required bool hardcoreMode,
    required ThemePreference themePreference,
    required Locale locale,
  }) = _UserProfile;
}
