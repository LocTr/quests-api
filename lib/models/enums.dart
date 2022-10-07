import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 3)
enum Repeat {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,
}

@HiveType(typeId: 4)
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

@HiveType(typeId: 5)
enum Difficulty {
  @HiveField(0)
  trivial,

  @HiveField(1)
  normal,

  @HiveField(2)
  hard,
}
