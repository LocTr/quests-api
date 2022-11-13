import 'package:hive/hive.dart';
import 'package:quests_api/models/goal.dart';
import 'package:rxdart/rxdart.dart';

class GoalsApi {
  GoalsApi({required Box<Goal> box}) : _box = box {
    _init();
  }

  _init() {
    _goalStreamController.add(_box.values.toList());

    _box.watch().listen((_) {
      _goalStreamController.add(_box.values.toList());
    });
  }

  final Box<Goal> _box;

  final _goalStreamController = BehaviorSubject<List<Goal>>.seeded(const []);

  Stream<List<Goal>> getGoalsStream() =>
      _goalStreamController.asBroadcastStream();

  Future<dynamic> closeGoalsStream() => _goalStreamController.close();

  Future<void> saveGoal(Goal goal) async {
    await _box.put(goal.id, goal);
  }

  Future<void> deleteGoal(String id) async {
    await _box.delete(id);
  }

  Future<List<Goal>> getGoals() async {
    return _box.values.toList();
  }

  Future<void> deleteAllGoals() async {
    await _box.clear();
  }
}
