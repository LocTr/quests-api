import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'progress_point.g.dart';

@HiveType(typeId: 4)
class ProgressPoint extends Equatable {
  @HiveField(0)
  final int point;

  @HiveField(1)
  final DateTime date;

  ProgressPoint({
    required this.point,
  }) : date = DateTime.now();

  static String getHiveKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  List<Object?> get props => [point, date];
}
