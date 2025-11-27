import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  // Obtain shared preferences.
  static late SharedPreferences prefs;

  static String? getLanguage() {
    return prefs.getString("lang");
  }

  static saveLanguage(String language) async {
    await prefs.setString("lang", language);
  }

  static saveTheme(String theme) async {
    await prefs.setString("theme", theme);
  }

  static String getMode() {
    return prefs.getString("theme") ?? "light";
  }
}
