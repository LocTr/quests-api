import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_api/models/progress_point.dart';

class ProgressPointApi {
  ProgressPointApi._create() {
    Hive.registerAdapter(ProgressPointAdapter());
  }

  static Future<ProgressPointApi> create(void init) async {
    ProgressPointApi api = ProgressPointApi._create();
    await api._asyncInit();
    return api;
  }

  _asyncInit() async {
    _box = await Hive.openBox('progress-points-box');
    _taskStreamController.add(_box.values.toList());
    _box.watch().listen((_) {
      _taskStreamController.add(_box.values.toList());
    });
  }

  late Box<ProgressPoint> _box;

  final _taskStreamController =
      BehaviorSubject<List<ProgressPoint>>.seeded(const []);

  Stream<List<ProgressPoint>> getTasksStream() =>
      _taskStreamController.asBroadcastStream();

  Future<void> saveProgress(ProgressPoint point) async {
    _box.getAt(_box.length + 1);

    await _box.add(point);
    return;
  }

  Future<void> deletePoint(String id) async {
    await _box.delete(id);
    return;
  }

  Future<void> deleteAll() async {
    await _box.clear();
    return;
  }

  Future<List<ProgressPoint>> getPoints() async {
    return _box.values.toList();
  }
}
