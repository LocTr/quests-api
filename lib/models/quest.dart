import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'enums.dart';

part 'quest.g.dart';

@HiveType(typeId: 1)
class Quest extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String detail;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updateAt;

  @HiveField(5)
  final Repeat repeat;

  @HiveField(6)
  final Difficulty difficulty;

  @HiveField(7)
  final Stat stat;

  @HiveField(8)
  final DateTime nextResetDate;

  @HiveField(9)
  final bool isDone;

  Quest({
    String? id,
    required this.title,
    this.detail = '',
    DateTime? createdAt,
    DateTime? updateAt,
    required this.repeat,
    this.difficulty = Difficulty.normal,
    this.stat = Stat.none,
    required this.nextResetDate,
    this.isDone = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updateAt = updateAt ?? DateTime.now();

  Quest copyWith({
    String? id,
    String? title,
    String? detail,
    DateTime? createdAt,
    DateTime? updateAt,
    Repeat? repeat,
    Difficulty? difficulty,
    Stat? stat,
    DateTime? nextResetDate,
    bool? isDone,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? DateTime.now(),
      repeat: repeat ?? this.repeat,
      difficulty: difficulty ?? this.difficulty,
      stat: stat ?? this.stat,
      nextResetDate: nextResetDate ?? this.nextResetDate,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        detail,
        createdAt,
        updateAt,
        repeat,
        difficulty,
        stat,
        nextResetDate,
      ];

  @override
  bool? get stringify => true;
}
