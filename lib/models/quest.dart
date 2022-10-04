import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

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

  Quest({
    this.id = '',
    required this.title,
    this.detail = '',
    DateTime? createdAt,
    DateTime? updateAt,
    required this.repeat,
  })  : createdAt = createdAt ?? DateTime.now(),
        updateAt = updateAt ?? DateTime.now();

  Quest copyWith({
    String? id,
    String? title,
    String? detail,
    DateTime? createdAt,
    DateTime? updateAt,
    int? totalTaskPoint,
    int? finishedTaskPoint,
    Repeat? repeat,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? DateTime.now(),
      repeat: repeat ?? this.repeat,
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
      ];

  @override
  bool? get stringify => true;
}

@HiveType(typeId: 2)
enum Repeat {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,
}
