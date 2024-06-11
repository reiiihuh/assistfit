import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _userNameKey = 'userName';
  static const String _userIdKey = 'user_id';

  // Function to save user name
  static Future<void> setUserName(String userName) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userNameKey, userName);
      print("User name saved successfully");
    } catch (e) {
      print("Error saving user name: $e");
    }
  }

  // Function to get user name
  static Future<String?> getUserName() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userNameKey);
    } catch (e) {
      print("Error getting user name: $e");
      return null;
    }
  }

  // Function to clear user name
  static Future<void> clearUserName() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userNameKey);
      print("User name cleared successfully");
    } catch (e) {
      print("Error clearing user name: $e");
    }
  }

  // Function to save user ID
  static Future<void> setUserId(int userId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_userIdKey, userId);
      print("User ID saved successfully");
    } catch (e) {
      print("Error saving user ID: $e");
    }
  }

  // Function to get user ID
  static Future<int?> getUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_userIdKey);
    } catch (e) {
      print("Error getting user ID: $e");
      return null;
    }
  }
}
