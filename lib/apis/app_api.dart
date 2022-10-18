import 'package:hive/hive.dart';
import 'package:quests_api/models/setting.dart';

class AppApi {
  AppApi({required Box<Setting> box}) : _box = box {
    _init();
  }

  _init() {}

  late Box<Setting> _box;

  final String _appSettingKey = 'app-setting-key';

  Setting getSetting() {
    var result = _box.get(_appSettingKey);
    if (result == null) {
      return Setting.initial();
    } else {
      return result;
    }
  }

  Future<void> updateSetting(Setting setting) async {
    await _box.put(_appSettingKey, setting);
  }
}
