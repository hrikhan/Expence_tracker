import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordObscured = true.obs;
  final isConfirmPasswordObscured = true.obs;
  final isLoading = false.obs;

  void togglePasswordObscured() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordObscured() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }

  bool validateLogin() {
    if (emailController.text.trim().isEmpty || !GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address.",
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar(
        "Invalid Password",
        "Password must be at least 6 characters.",
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  bool validateSignUp() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        "Invalid Name",
        "Please enter your full name.",
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    }
    if (emailController.text.trim().isEmpty || !GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address.",
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar(
        "Invalid Password",
        "Password must be at least 6 characters.",
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Password Mismatch",
        "Passwords do not match.",
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
