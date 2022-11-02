import 'package:hive/hive.dart';
import 'package:quests_api/models/quest.dart';
import 'package:rxdart/rxdart.dart';

class QuestsApi {
  QuestsApi({required Box<Quest> box}) : _box = box {
    _init();
  }

  _init() {
    _questStreamController.add(_box.values.toList());

    _box.watch().listen((_) {
      _questStreamController.add(_box.values.toList());
    });
  }

  final Box<Quest> _box;

  final _questStreamController = BehaviorSubject<List<Quest>>.seeded(const []);

  Stream<List<Quest>> getQuestsStream() =>
      _questStreamController.asBroadcastStream();

  Future<dynamic> closeQuestsStream() => _questStreamController.close();

  Future<void> saveQuest(Quest quest) async {
    await _box.put(quest.id, quest);
  }

  Future<void> deleteQuest(String id) async {
    await _box.delete(id);
  }

  Future<List<Quest>> getQuests() async {
    return _box.values.toList();
  }

  Future<void> deleteAllQuests() async {
    await _box.clear();
  }
}
