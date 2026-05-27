enum Weekday {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun;

  int get bit => 1 << index;

  static Set<Weekday> fromMask(int mask) =>
      Weekday.values.where((d) => (mask & d.bit) != 0).toSet();

  static int toMask(Set<Weekday> days) =>
      days.fold(0, (acc, d) => acc | d.bit);
}
