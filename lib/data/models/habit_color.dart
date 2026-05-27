import 'package:flutter/material.dart';

import '../../ui/core/themes/color_tokens.dart';

enum HabitColor {
  purple(HabitiousColors.brandPurple),
  teal(HabitiousColors.accentTeal),
  orange(HabitiousColors.accentOrange),
  pink(HabitiousColors.accentPink),
  blue(HabitiousColors.accentBlue),
  red(HabitiousColors.accentRed);

  const HabitColor(this.value);
  final Color value;
}
