import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime createdDate;

  @HiveField(3)
  final DateTime completedDate;

  @HiveField(4)
  final int totalTaskPoint;

  @HiveField(5)
  final int finishedTaskPoint;

  @HiveField(6)
  final List<Group> groups;

  @HiveField(7)
  final List<Subtask> subtasks;

  Task({
    String? id,
    required this.title,
    required this.createdDate,
    required this.completedDate,
    required this.totalTaskPoint,
    required this.finishedTaskPoint,
    this.groups = const [],
    this.subtasks = const [],
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  Task copyWith({
    String? id,
    String? title,
    DateTime? createdDate,
    DateTime? completedDate,
    int? totalTaskPoint,
    int? finishedTaskPoint,
    List<Group>? groups,
    List<Subtask>? subtasks,
  }) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
        completedDate: completedDate ?? this.completedDate,
        totalTaskPoint: totalTaskPoint ?? this.totalTaskPoint,
        finishedTaskPoint: finishedTaskPoint ?? this.finishedTaskPoint);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdDate,
        completedDate,
        totalTaskPoint,
        finishedTaskPoint,
        groups,
        subtasks,
      ];

  @override
  bool? get stringify => true;
}

@HiveType(typeId: 2)
class Subtask extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isDone;

  Subtask({String? id, required this.title, required this.isDone})
      : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  Subtask copyWith({String? title, bool? isDone}) {
    return Subtask(title: title ?? this.title, isDone: isDone ?? this.isDone);
  }

  @override
  List<Object?> get props => [id, title, isDone];
}

@HiveType(typeId: 3)
class Group extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  Group({String? id, required this.title})
      : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, title];
}
