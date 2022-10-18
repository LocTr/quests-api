import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class Setting {
  @HiveField(0)
  final DateTime lastLoggedDate;
  @HiveField(1)
  final bool isDarkTheme;

  Setting({
    required this.lastLoggedDate,
    this.isDarkTheme = false,
  });

  Setting.initial()
      : lastLoggedDate = DateTime.now(),
        isDarkTheme = false;

  Setting copyWith(DateTime? lastLoggedDate, bool? isDarkTheme) {
    return Setting(
      lastLoggedDate: lastLoggedDate ?? this.lastLoggedDate,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
