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
      backgroundColor: AppColors.background,
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
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: AppColors.white,
                        size: 32.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Welcome Header
                  Text(
                    AppStrings.welcomeBack.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.loginSubtitle.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  // Email Input Field
                  Text(
                    AppStrings.email.tr,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: AppStrings.enterEmail.tr,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined, size: 20.r, color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 20.h),
                  // Password Input Field
                  Text(
                    AppStrings.password.tr,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        hintText: AppStrings.enterPassword.tr,
                        obscureText: controller.isPasswordObscured.value,
                        prefixIcon: Icon(Icons.lock_outlined, size: 20.r, color: AppColors.textSecondary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.r,
                            color: AppColors.textSecondary,
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
                        AppStrings.forgotPassword.tr,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Log In Button
                  Obx(() => CustomButton(
                        text: AppStrings.login.tr,
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
                        text: AppStrings.dontHaveAccount.tr,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.signup.tr,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
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
