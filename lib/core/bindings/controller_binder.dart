

import 'package:get/get.dart';
import '../../features/navigation/controllers/navigation_controller.dart';
import '../../features/authentication/controllers/auth_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
      fenix: true,
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }
}