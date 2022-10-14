import 'package:hive/hive.dart';
import 'package:quests_api/models/enums.dart';
import 'package:quests_api/models/goal.dart';
import 'package:quests_api/models/quest.dart';
import 'package:rxdart/rxdart.dart';

class QuestsApi {
  QuestsApi({required Box<Quest> plugin, required HiveInterface hiveInterface})
      : _plugin = plugin,
        _hiveInterface = hiveInterface {
    _init();
  }

  _init() {
    _hiveInterface
      ..registerAdapter(QuestAdapter())
      ..registerAdapter(GoalAdapter())
      ..registerAdapter(DifficultyAdapter())
      ..registerAdapter(StatAdapter())
      ..registerAdapter(RepeatAdapter());
    _questStreamController.add(_plugin.values.toList());

    _plugin.watch().listen((_) {
      _questStreamController.add(_plugin.values.toList());
    });
  }

  final HiveInterface _hiveInterface;

  final Box<Quest> _plugin;

  final _questStreamController = BehaviorSubject<List<Quest>>.seeded(const []);

  Stream<List<Quest>> getQuestsStream() =>
      _questStreamController.asBroadcastStream();

  Future<dynamic> closeQuestsStream() => _questStreamController.close();

  Future<void> saveQuest(Quest task) async {
    await _plugin.put(task.id, task);
    return;
  }

  Future<void> deleteQuest(String id) async {
    await _plugin.delete(id);
    return;
  }

  Future<List<Quest>> getQuests() async {
    return _plugin.values.toList();
  }
}
