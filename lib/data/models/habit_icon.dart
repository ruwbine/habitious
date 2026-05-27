import 'package:flutter/material.dart';

enum HabitIcon {
  drop(Icons.water_drop_outlined),
  dumbbell(Icons.fitness_center_outlined),
  book(Icons.menu_book_outlined),
  lotus(Icons.self_improvement_outlined),
  run(Icons.directions_run_outlined),
  apple(Icons.local_pizza_outlined);

  const HabitIcon(this.iconData);
  final IconData iconData;
}
