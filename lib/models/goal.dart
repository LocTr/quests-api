import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:quests_api/models/enums.dart';

part 'goal.g.dart';

@HiveType(typeId: 2)
class Goal extends Equatable {
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
  final bool isDone;

  @HiveField(6)
  final Difficulty difficulty;

  Goal(
      {this.id = '',
      required this.title,
      this.detail = '',
      DateTime? createdAt,
      DateTime? updateAt,
      this.isDone = false,
      this.difficulty = Difficulty.normal})
      : createdAt = createdAt ?? DateTime.now(),
        updateAt = updateAt ?? DateTime.now();

  Goal copyWith({
    String? id,
    String? title,
    String? detail,
    DateTime? createdAt,
    DateTime? updateAt,
    bool? isDone,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? DateTime.now(),
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
