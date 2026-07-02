import 'package:get/get.dart';

import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/authentication/presentation/screens/signup_screen.dart';
import '../features/authentication/presentation/screens/splash_screen.dart';
import '../features/navigation/presentation/screens/navigation_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";
  static String navigationScreen = "/navigationScreen";

  static String getSplashScreen() => splashScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getNavigationScreen() => navigationScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: navigationScreen, page: () => const NavigationScreen()),
  ];
}
