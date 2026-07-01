import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences? preferences;
  SharedPrefs() {
    _initializeSharedPrefs();
  }

  _initializeSharedPrefs() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  static const authToken = "authToken";
  // static const phone = "phone";

  Future<String?> getAuthToken() async {
    String? stringValue = preferences?.getString(authToken);
    return stringValue;
  }

  Future<String?> getphone() async {
    String? stringValue = preferences?.getString("name");
    return stringValue;
  }

  Future<int?> getsettings() async {
    int? stringValue = preferences?.getInt("settings");
    return stringValue;
  }

  Future<bool?> getactive() async {
    bool? stringValue = preferences?.getBool("active");
    return stringValue;
  }

  Future<int?> getid() async {
    int? stringValue = preferences?.getInt("id");
    return stringValue;
  }

  Future<void> saveAuthToken({required String token}) async {
    await preferences?.setString(authToken, token);
  }

  Future<void> savephone({required String name}) async {
    await preferences?.setString("name", name);
  }

  Future<void> saveid({required int id}) async {
    await preferences?.setInt("id", id);
  }

  Future<void> saveactive({required bool active}) async {
    await preferences?.setBool("active", active);
  }

  Future<void> savesettings({required int settings}) async {
    await preferences?.setInt("settings", settings);
  }

  Future<void> clearToken() async {
    await preferences?.remove("name");
    await preferences?.remove("active");
    await preferences?.remove("settings");
    await preferences?.remove("authToken");
  }
}
