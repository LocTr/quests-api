import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 10)
enum Repeat {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,
}

@HiveType(typeId: 11)
enum Stat {
  @HiveField(0)
  none,

  @HiveField(1)
  physical,

  @HiveField(2)
  intelligence,

  @HiveField(3)
  mental,
}

@HiveType(typeId: 12)
enum Difficulty {
  @HiveField(0)
  trivial,

  @HiveField(1)
  normal,

  @HiveField(2)
  hard,
}

@HiveType(typeId: 13)
enum Bounty {
  @HiveField(0)
  none,

  @HiveField(1)
  small,

  @HiveField(2)
  medium,

  @HiveField(3)
  large,
}
