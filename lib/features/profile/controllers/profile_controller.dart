import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/core/core.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import '../data/models/profile_model.dart';

class ProfileController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final isLoading = false.obs;
  final profile = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) {
        return;
      }

      final response = await _networkCaller.getRequest(
        ApiConstants.profile,
        token: 'Bearer $token',
      );

      if (response.isSuccess) {
        profile.value = UserProfileModel.fromJson(response.responseData);
      } else {
        Get.snackbar(
          "Error",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Failed to load profile.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await StorageService.logoutUser();
    Get.offAllNamed(AppRoute.loginScreen);
  }
}
