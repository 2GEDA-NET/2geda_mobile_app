import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setReactionType(String reactionType, String key) async =>
      await _preferences.setString(key, reactionType);

  static String? getReactionType(String key) => _preferences.getString(key);
}
