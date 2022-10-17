import 'package:hive/hive.dart';
import 'package:quests_api/models/enums.dart';
import 'package:quests_api/models/goal.dart';
import 'package:quests_api/models/quest.dart';
import 'package:rxdart/rxdart.dart';

class QuestsApi {
  QuestsApi({required Box<Quest> box, required HiveInterface hiveInterface})
      : _box = box,
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
    _questStreamController.add(_box.values.toList());

    _box.watch().listen((_) {
      _questStreamController.add(_box.values.toList());
    });
  }

  final HiveInterface _hiveInterface;

  final Box<Quest> _box;

  final _questStreamController = BehaviorSubject<List<Quest>>.seeded(const []);

  Stream<List<Quest>> getQuestsStream() =>
      _questStreamController.asBroadcastStream();

  Future<dynamic> closeQuestsStream() => _questStreamController.close();

  Future<void> saveQuest(Quest quest) async {
    await _box.put(quest.id, quest);
    return;
  }

  Future<void> deleteQuest(String id) async {
    await _box.delete(id);
    return;
  }

  Future<List<Quest>> getQuests() async {
    return _box.values.toList();
  }
}
