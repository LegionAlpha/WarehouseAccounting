import 'package:shared_preferences/shared_preferences.dart';

class SessionStore {
  const SessionStore(this._prefs);

  final SharedPreferences _prefs;

  static const String _userIdKey = 'session_user_id';

  int? readUserId() => _prefs.getInt(_userIdKey);

  Future<void> saveUserId(int id) => _prefs.setInt(_userIdKey, id);

  Future<void> clear() => _prefs.remove(_userIdKey);
}
