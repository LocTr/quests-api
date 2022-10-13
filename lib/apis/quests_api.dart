import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quests_api/models/enums.dart';
import 'package:quests_api/models/goal.dart';
import 'package:quests_api/models/quest.dart';
import 'package:rxdart/rxdart.dart';

class QuestsApi {
  QuestsApi._create() {
    Hive
      ..registerAdapter(QuestAdapter())
      ..registerAdapter(GoalAdapter())
      ..registerAdapter(DifficultyAdapter())
      ..registerAdapter(StatAdapter())
      ..registerAdapter(RepeatAdapter());
  }

  static Future<QuestsApi> create() async {
    QuestsApi api = QuestsApi._create();
    await api._asyncInit();

    return api;
  }

  _asyncInit() async {
    box = await Hive.openBox('quests-box');
    _questStreamController.add(box.values.toList());
    box.watch().listen((_) {
      _questStreamController.add(box.values.toList());
    });
  }

  @visibleForTesting
  late Box<Quest> box;

  final _questStreamController = BehaviorSubject<List<Quest>>.seeded(const []);

  Stream<List<Quest>> getQuestsStream() =>
      _questStreamController.asBroadcastStream();

  Future<dynamic> closeQuestsStream() => _questStreamController.close();

  Future<void> saveQuest(Quest task) async {
    await box.put(task.id, task);
    return;
  }

  Future<void> deleteQuest(String id) async {
    await box.delete(id);
    return;
  }

  Future<List<Quest>> getQuests() async {
    return box.values.toList();
  }
}
