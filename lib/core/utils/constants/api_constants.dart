import 'package:flutter/foundation.dart';

class ApiConstants {
  static String get baseUrl =>
      'https://expence-tracker-backend-s6ku.onrender.com';

  static String get signUp => '$baseUrl/auth/signup';
  static String get login => '$baseUrl/auth/login';
  static String get profile => '$baseUrl/users/profile';
  static String get tracker => '$baseUrl/tracker';
  static String get trackerToday => '$baseUrl/tracker/today';
}
