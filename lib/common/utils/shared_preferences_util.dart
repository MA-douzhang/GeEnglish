import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {

  SharedPreferences? sharedPreferences ;

  static SharedPreferencesUtil? getInstance() {
    return SharedPreferencesUtil();
  }

  Future setBool(String tag, bool isFirst) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(tag, isFirst);
  }

  Future getBool(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(tag);
  }

  Future getString(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tag);
  }

  Future<bool> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
