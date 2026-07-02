import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/core/core.dart';

class AuthController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();
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

  Future<bool> signUp() async {
    isLoading.value = true;
    try {
      final response = await _networkCaller.postRequest(
        ApiConstants.signUp,
        body: {
          'email': emailController.text.trim(),
          'password': passwordController.text,
        },
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Account created successfully! Please log in.",
          backgroundColor: const Color(0xFF8A7665),
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          "Sign Up Failed",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Something went wrong.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login() async {
    isLoading.value = true;
    try {
      final response = await _networkCaller.postRequest(
        ApiConstants.login,
        body: {
          'email': emailController.text.trim(),
          'password': passwordController.text,
        },
      );

      if (response.isSuccess) {
        final Map<String, dynamic> data = response.responseData;
        final token = data['token'];
        if (token != null && token.toString().isNotEmpty) {
          await StorageService.saveToken(token.toString());
          Get.snackbar(
            "Success",
            "Logged in successfully!",
            backgroundColor: const Color(0xFF8A7665),
            colorText: Colors.white,
          );
          return true;
        } else {
          Get.snackbar(
            "Login Failed",
            "Invalid response from server.",
            backgroundColor: const Color(0xFFC84C4C),
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        Get.snackbar(
          "Login Failed",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Invalid email or password.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
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
