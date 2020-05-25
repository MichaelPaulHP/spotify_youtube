import 'package:shared_preferences/shared_preferences.dart';

class CodeRepository{
  static const String CODE_KEY = "spotiy_code";

  static Future<String>getCode() async {
    final prefs = await SharedPreferences.getInstance();
    final String code = prefs.getString(CODE_KEY) ?? null;
    return code;
  }
  static Future<void> saveCode(String code)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(CODE_KEY, code);
  }
  static Future<void> clearCode() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(CODE_KEY);

  }

}