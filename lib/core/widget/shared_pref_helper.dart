import 'package:flutter_e_commerce_c11_online/core/widget/shared_prefernce_utils.dart';



class SharedPrefHelper {
  static const String tokenKey = "token";
  static const String nameKey = "name";
  static const String emailKey = "email";
  static const String roleKey = "role";

  static Future<void> saveToken(String token) async {
    await SharedPreferenceUtils.saveData(
      key: tokenKey,
      value: token,
    );
  }

  static Future<void> saveName(String name) async {
    await SharedPreferenceUtils.saveData(
      key: nameKey,
      value: name,
    );
  }

  static Future<void> saveEmail(String email) async {
    await SharedPreferenceUtils.saveData(
      key: emailKey,
      value: email,
    );
  }

  static Future<void> saveRole(String role) async {
    await SharedPreferenceUtils.saveData(
      key: roleKey,
      value: role,
    );
  }

  static String get token =>
      SharedPreferenceUtils.getData(key: tokenKey) as String? ?? "";

  static String get name =>
      SharedPreferenceUtils.getData(key: nameKey) as String? ?? "";

  static String get email =>
      SharedPreferenceUtils.getData(key: emailKey) as String? ?? "";

  static String get role =>
      SharedPreferenceUtils.getData(key: roleKey) as String? ?? "";

  static Future<void> clear() async {
    await SharedPreferenceUtils.removeData(key: tokenKey);
    await SharedPreferenceUtils.removeData(key: nameKey);
    await SharedPreferenceUtils.removeData(key: emailKey);
    await SharedPreferenceUtils.removeData(key: roleKey);
  }
}