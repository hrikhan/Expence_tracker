

import 'package:get/get.dart';
import '../../features/navigation/controllers/navigation_controller.dart';
import '../../features/authentication/controllers/auth_controller.dart';
import '../../features/profile/controllers/profile_controller.dart';
import '../../features/tracker/controllers/tracker_controller.dart';

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
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut<TrackerController>(
      () => TrackerController(),
      fenix: true,
    );
  }
}