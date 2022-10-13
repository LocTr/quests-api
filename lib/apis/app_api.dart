import 'package:shared_preferences/shared_preferences.dart';

class AppApi {
  AppApi._create();

  static Future<AppApi> create() async {
    AppApi api = AppApi._create();
    api._asyncInit();
    return api;
  }

  _asyncInit() async {
    _prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences _prefs;

  final String _lastLoggedDateKey = 'last-logged-date';

  DateTime getLastLoggedDate() {
    int? result = _prefs.getInt(_lastLoggedDateKey);

    if (result == null) {
      return DateTime.now();
    } else {
      return DateTime.fromMillisecondsSinceEpoch(result);
    }
  }

  void updateLastLogedDate() async {
    await _prefs.setInt(
        _lastLoggedDateKey, DateTime.now().millisecondsSinceEpoch);
  }
}
