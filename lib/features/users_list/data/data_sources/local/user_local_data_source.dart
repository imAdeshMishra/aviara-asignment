import 'dart:convert';
import 'package:aviara/features/users_list/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static const String key = "CACHED_USERS";

  Future<void> cacheUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = users.map((user) => user.toJson()).toList();

    await prefs.setString(key, jsonEncode(jsonList));
  }

  Future<List<UserModel>?> getCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    if (data != null) {
      final List decoded = jsonDecode(data);

      return decoded.map((e) => UserModel.fromJson(e)).toList();
    }

    return null;
  }
}
