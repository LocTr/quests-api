import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasks_api/models/task.dart';

class TasksApi {
  TasksApi._create() {
    Hive
      ..registerAdapter(TaskAdapter())
      ..registerAdapter(SubtaskAdapter())
      ..registerAdapter(GroupAdapter());
  }

  static Future<TasksApi> create() async {
    TasksApi api = TasksApi._create();
    await api._asyncInit();
    return api;
  }

  _asyncInit() async {
    _box = await Hive.openBox('tasks-box');
    _taskStreamController.add(_box.values.toList());
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

  Future<void> deleteAll() async {
    await _box.clear();
    return;
  }

  Future<List<Task>> getTasks() async {
    return _box.values.toList();
  }
}
