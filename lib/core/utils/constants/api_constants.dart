import 'package:flutter/foundation.dart';

class ApiConstants {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    }
    return defaultTargetPlatform == TargetPlatform.android
        ? 'http://10.0.2.2:3000'
        : 'http://localhost:3000';
  }

  static String get signUp => '$baseUrl/auth/signup';
  static String get login => '$baseUrl/auth/login';
  static String get profile => '$baseUrl/users/profile';
  static String get tracker => '$baseUrl/tracker';
  static String get trackerToday => '$baseUrl/tracker/today';
}
