import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {
  static SharedPreferences? sharedObject;

  static init() async {
    sharedObject = await SharedPreferences.getInstance();
  }

  bool getCachedMood({required String key}) {
    bool? mood = sharedObject!.getBool(key) ?? false;
    return mood;
  }

  Future<bool> setCachedMood({required String key, required bool value}) async {
    return await sharedObject!.setBool(key, value);
  }
}
