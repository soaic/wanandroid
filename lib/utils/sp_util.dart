
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SPUtil {

  static SPUtil _singleton;

  static Lock _lock = Lock();

  static SharedPreferences _prefs;

  static Future<SPUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = SPUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SPUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic get(String key, dynamic def) {
    if (_prefs == null) return null;
    return _prefs.get(key) ?? def;
  }

  static Future<bool> remove(String key) async {
    if (_prefs == null) return null;
    return _prefs.remove(key);
  }

  static Future<bool> putInt(String key, int value) async {
    if (_prefs == null) return null;
    return _prefs.setInt(key, value);
  }

  static Future<bool> putString(String key, String value) async {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }

  static Future<bool> putBool(String key, bool value) async {
    if (_prefs == null) return null;
    return _prefs.setBool(key, value);
  }

  static Future<bool> putDouble(String key, double value) async {
    if (_prefs == null) return null;
    return _prefs.setDouble(key, value);
  }

  static Future<bool> putStringList(String key, List<String> value) async {
    if (_prefs == null) return null;
    return _prefs.setStringList(key, value);
  }

}