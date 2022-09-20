import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:task_api/models/task.dart';

void main() {
  test('test db', () async {
    Hive
      ..init('test-box')
      ..registerAdapter(TaskAdapter())
      ..registerAdapter(SubtaskAdapter())
      ..registerAdapter(GroupAdapter());
    var box = await Hive.openBox('testBox');
    final taskToAdd = Task(
        title: 'Exercise',
        createdDate: DateTime.now(),
        completedDate: DateTime.now(),
        totalTaskPoint: 5,
        finishedTaskPoint: 0,
        subtasks: [
          Subtask(title: 'push up x50', isDone: true),
          Subtask(title: 'pull up x 30', isDone: false),
          Subtask(title: 'band raise x 40', isDone: false),
          Subtask(title: 'more push up x50 ', isDone: false),
        ],
        groups: [
          Group(title: 'Exercise')
        ]);

    print(taskToAdd.id);
    print(taskToAdd.id);
    print(taskToAdd.id);

    await box.put(taskToAdd.id, taskToAdd);
    await box.put(taskToAdd.id, taskToAdd);
    await box.put(taskToAdd.id, taskToAdd);

    Task savedTask = box.get(taskToAdd.id);
    print(savedTask.id);
  });
}
