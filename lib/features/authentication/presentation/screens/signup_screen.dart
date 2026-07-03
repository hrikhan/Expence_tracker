import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/core/core.dart';

import 'package:expense_tracker/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

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
                        Icons.person_add_alt_1_outlined,
                        color: AppColors.white,
                        size: 32.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Header
                  Text(
                    AppStrings.createAccount.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.signupSubtitle.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  // Name Field
                  Text(
                    AppStrings.fullName.tr,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: AppStrings.enterName.tr,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(Icons.person_outline, size: 20.r, color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 20.h),
                  // Email Field
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
                  // Age Field
                  Text(
                    AppStrings.age.tr,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: controller.ageController,
                    hintText: AppStrings.enterAge.tr,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.calendar_today_outlined, size: 20.r, color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 20.h),
                  // Password Field
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
                  SizedBox(height: 20.h),
                  // Confirm Password Field
                  Text(
                    AppStrings.confirmPassword.tr,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: AppStrings.confirmYourPassword.tr,
                        obscureText: controller.isConfirmPasswordObscured.value,
                        prefixIcon: Icon(Icons.lock_outlined, size: 20.r, color: AppColors.textSecondary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.r,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: controller.toggleConfirmPasswordObscured,
                        ),
                      )),
                  SizedBox(height: 32.h),
                  // Sign Up Button
                  Obx(() => CustomButton(
                        text: AppStrings.createAccount.tr,
                        isLoading: controller.isLoading.value,
                        onPressed: () async {
                          if (controller.validateSignUp()) {
                            final success = await controller.signUp();
                            if (success) {
                              controller.clearFields();
                              Get.offAllNamed(AppRoute.getLoginScreen());
                            }
                          }
                        },
                      )),
                  SizedBox(height: 24.h),
                  // Log In Link
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: AppStrings.alreadyHaveAccount.tr,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.login.tr,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
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
