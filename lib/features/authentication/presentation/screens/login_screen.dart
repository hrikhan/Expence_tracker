import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/core/core.dart';

import '../../controllers/auth_controller.dart';
import '../../../../routes/app_routes.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

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
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 32.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Welcome Header
                  Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Log in to track and optimize your expenses",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF8C8681),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  // Email Input Field
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
                  // Password Input Field
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
                  SizedBox(height: 12.h),
                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFB09F92),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Log In Button
                  Obx(() => CustomButton(
                        text: "Log In",
                        isLoading: controller.isLoading.value,
                        onPressed: () async {
                          if (controller.validateLogin()) {
                            final success = await controller.login();
                            if (success) {
                              controller.clearFields();
                              Get.offAllNamed(AppRoute.getNavigationScreen());
                            }
                          }
                        },
                      )),
                  SizedBox(height: 24.h),
                  // Sign Up Navigation Link
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xFF8C8681),
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF231C18),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.clearFields();
                                Get.toNamed(AppRoute.getSignUpScreen());
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
