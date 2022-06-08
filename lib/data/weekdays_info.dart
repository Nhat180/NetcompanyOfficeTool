class WeekDayInfo {
  final int position;
  final String name;
  final String abbrev;

  WeekDayInfo(this.position, this.name, this.abbrev);

}

List<WeekDayInfo> weekdays = [
  WeekDayInfo(2, "Monday", "mon"),
  WeekDayInfo(3, "Tuesday", "tue"),
  WeekDayInfo(4, "Wednesday", "wed"),
  WeekDayInfo(5, "Thursday", "thu"),
  WeekDayInfo(6, "Friday", "fri")
];