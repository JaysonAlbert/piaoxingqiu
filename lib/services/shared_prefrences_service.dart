// shared_preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  String? get accessToken => _preferences?.getString('accessToken');

  Future<void> setAccessToken(String token) async {
    await _preferences?.setString('accessToken', token);
  }

  Future<void> removeAccessToken() async {
    await _preferences?.remove('accessToken');
  }

  Future<void> setPhone(String phone) async {
    await _preferences?.setString('phone', phone);
  }

  String? get phone => _preferences?.getString('phone');

  Future<void> removePhone() async {
    await _preferences?.remove('phone');
  }

  Future<void> setRefreshToken(String token) async {
    await _preferences?.setString('refreshToken', token);
  }

  String? get refreshToken => _preferences?.getString('refreshToken');

  Future<void> removeRefreshToken() async {
    await _preferences?.remove('refreshToken');
  }

  bool get isLogin => phone != null &&   accessToken != null;
}
