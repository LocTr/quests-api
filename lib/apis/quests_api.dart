import 'package:hive/hive.dart';
import 'package:quests_api/models/quest.dart';
import 'package:rxdart/rxdart.dart';

class QuestsApi {
  QuestsApi._create() {
    Hive
      ..registerAdapter(QuestAdapter())
      ..registerAdapter(RepeatAdapter());
  }

  static Future<QuestsApi> create() async {
    QuestsApi api = QuestsApi._create();
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

  late Box<Quest> _box;

  final _taskStreamController = BehaviorSubject<List<Quest>>.seeded(const []);

  Stream<List<Quest>> getTasksStream() =>
      _taskStreamController.asBroadcastStream();

  Future<void> saveQuest(Quest task) async {
    await _box.put(task.id, task);
    return;
  }

  Future<void> deleteQuest(String id) async {
    await _box.delete(id);
    return;
  }

  Future<List<Quest>> getTasks() async {
    return _box.values.toList();
  }
}
