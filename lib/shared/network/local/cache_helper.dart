import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static getDate({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }
  static Future removeDate({
    required String key,
  }) {
    return sharedPreferences!.remove(key);
  }


  static Future<bool> saveDate({
    required String key,
    required dynamic value,
}) async{
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is String) return await sharedPreferences!.setString(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }
}
