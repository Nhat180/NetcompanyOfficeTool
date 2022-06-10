class WeekDayInfo {
  final int position;
  final String name;
  final String abbrev;
  final String iconImage;

  WeekDayInfo(this.position, this.name, this.abbrev, this.iconImage);

}

List<WeekDayInfo> weekdays = [
  WeekDayInfo(2, "Monday", "mon", "images/food 1.png"),
  WeekDayInfo(3, "Tuesday", "tue", "images/hot-pot.png"),
  WeekDayInfo(4, "Wednesday", "wed", "images/tom-yum-goong.png"),
  WeekDayInfo(5, "Thursday", "thu", "images/food 5.png"),
  WeekDayInfo(6, "Friday", "fri", "images/food 2.png")
];