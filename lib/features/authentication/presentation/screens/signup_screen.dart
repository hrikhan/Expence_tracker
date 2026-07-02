import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/core/core.dart';

import '../../controllers/auth_controller.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo/App Icon Placeholder
                  Center(
                    child: Container(
                      width: 64.w,
                      height: 64.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF231C18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_add_alt_1_outlined,
                        color: Colors.white,
                        size: 32.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Header
                  Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Join us to manage your budget easily",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF8C8681),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  // Name Field
                  Text(
                    "Full Name",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: "Enter your full name",
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(Icons.person_outline, size: 20.r, color: const Color(0xFF8C8681)),
                  ),
                  SizedBox(height: 20.h),
                  // Email Field
                  Text(
                    "Email Address",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined, size: 20.r, color: const Color(0xFF8C8681)),
                  ),
                  SizedBox(height: 20.h),
                  // Password Field
                  Text(
                    "Password",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        hintText: "Enter your password",
                        obscureText: controller.isPasswordObscured.value,
                        prefixIcon: Icon(Icons.lock_outlined, size: 20.r, color: const Color(0xFF8C8681)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.r,
                            color: const Color(0xFF8C8681),
                          ),
                          onPressed: controller.togglePasswordObscured,
                        ),
                      )),
                  SizedBox(height: 20.h),
                  // Confirm Password Field
                  Text(
                    "Confirm Password",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: "Confirm your password",
                        obscureText: controller.isConfirmPasswordObscured.value,
                        prefixIcon: Icon(Icons.lock_outlined, size: 20.r, color: const Color(0xFF8C8681)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.r,
                            color: const Color(0xFF8C8681),
                          ),
                          onPressed: controller.toggleConfirmPasswordObscured,
                        ),
                      )),
                  SizedBox(height: 32.h),
                  // Sign Up Button
                  Obx(() => CustomButton(
                        text: "Create Account",
                        isLoading: controller.isLoading.value,
                        onPressed: () async {
                          if (controller.validateSignUp()) {
                            final success = await controller.signUp();
                            if (success) {
                              controller.clearFields();
                              Get.back();
                            }
                          }
                        },
                      )),
                  SizedBox(height: 24.h),
                  // Log In Link
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xFF8C8681),
                        ),
                        children: [
                          TextSpan(
                            text: "Log In",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF231C18),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.clearFields();
                                Get.back();
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
