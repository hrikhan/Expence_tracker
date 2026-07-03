import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/core/core.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const CustomLoadingIndicator();
                }

                final user = controller.profile.value;

                return Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: 400.w),
                  padding: EdgeInsets.all(28.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF231C18).withOpacity(0.06),
                        blurRadius: 24.r,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 88.r,
                        height: 88.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFF231C18).withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 40.r,
                          color: const Color(0xFF231C18),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      if (user == null) ...[
                        Text(
                          "Authentication Required",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF231C18),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Could not retrieve profile information. Please verify your connection or sign in again.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            color: const Color(0xFF8C8681),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          text: AppStrings.retry.tr,
                          onPressed: controller.getProfile,
                        ),
                      ] else ...[
                        Text(
                          user.fullName ?? "Guest User",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF231C18),
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          user.email,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: const Color(0xFF8C8681),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        const Divider(color: Color(0xFFEAE7E4), height: 1),
                        SizedBox(height: 20.h),
                        
                        _buildInfoRow(
                          icon: Icons.badge_outlined,
                          label: "User ID",
                          value: "#${user.id}",
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Icons.cake_outlined,
                          label: "Age",
                          value: user.age != null ? "${user.age} years" : "N/A",
                        ),
                      ],

                      SizedBox(height: 28.h),
                      const Divider(color: Color(0xFFEAE7E4), height: 1),
                      SizedBox(height: 24.h),

                      CustomButton(
                        text: AppStrings.logout.tr,
                        onPressed: controller.logout,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Powered by Every Day",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF8C8681),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: const Color(0xFF231C18).withOpacity(0.03),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 18.r, color: const Color(0xFF8C8681)),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8C8681),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF231C18),
          ),
        ),
      ],
    );
  }
}
