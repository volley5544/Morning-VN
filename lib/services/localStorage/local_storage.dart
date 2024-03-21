import 'package:shared_preferences/shared_preferences.dart';

class LocalStoragePrefernces {
  var _prefs;
  LocalStoragePrefernces() {
    ini();
  }
  ini() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  Future removeLocalStorage(String key) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(key);
  }

  Future getLocalStorage(String key, String dataType) async {
    _prefs = await SharedPreferences.getInstance();

    if (dataType == 'string') {
      return await _prefs.getString(key);
    }
    if (dataType == 'bool') {
      return await _prefs.getBool(key);
    }
    if (dataType == 'double') {
      return await _prefs.getDouble(key);
    }
    if (dataType == 'int') {
      return await _prefs.getInt(key);
    }
    if (dataType == 'listString') {
      return await _prefs.getStringList(key);
    }
  }

  Future setLocalStorage(String key, dynamic value, String inputType) async {
    _prefs = await SharedPreferences.getInstance();

    if (inputType == 'string') {
      await _prefs.setString(key, value);
    }
    if (inputType == 'bool') {
      await _prefs.setBool(key, value);
    }
    if (inputType == 'double') {
      await _prefs.setDouble(key, value);
    }
    if (inputType == 'int') {
      await _prefs.setInt(key, value);
    }
    if (inputType == 'listString') {
      await _prefs.setStringList(key, <String>[value]);
    }
  }
}
