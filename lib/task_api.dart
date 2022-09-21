library task_api;

import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_api/models/task.dart';

class TaskApi {
  TaskApi._create() {
    Hive
      ..init('test-box')
      ..registerAdapter(TaskAdapter())
      ..registerAdapter(SubtaskAdapter())
      ..registerAdapter(GroupAdapter());
  }

  static Future<TaskApi> create() async {
    TaskApi api = TaskApi._create();
    await api._asyncInit();
    return api;
  }

  _asyncInit() async {
    _box = await Hive.openBox('test-box');
    _box.watch().listen((_) {
      _taskStreamController.add(_box.values.toList());
    });
  }

  late Box<Task> _box;

  final _taskStreamController = BehaviorSubject<List<Task>>.seeded(const []);

  Stream<List<Task>> getTasksStream() =>
      _taskStreamController.asBroadcastStream();

  Future<void> saveTask(Task task) async {
    await _box.put(task.id, task);
    return;
  }

  Future<void> deleteTask(String id) async {
    await _box.delete(id);
    return;
  }

  Future<List<Task>> getTasks() async {
    return _box.values.toList();
  }
}
