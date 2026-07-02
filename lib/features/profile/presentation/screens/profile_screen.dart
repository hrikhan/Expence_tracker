import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF231C18)),
            );
          }

          final user = controller.profile.value;
          if (user == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No profile data loaded",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: const Color(0xFF8C8681),
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.getProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF231C18),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Retry"),
                ),
              ],
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundColor: const Color(0xFFEAE7E4),
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
                ),
                onBackgroundImageError: (_, __) {},
                child: Icon(Icons.person, size: 50.r, color: const Color(0xFF231C18)),
              ),
              SizedBox(height: 16.h),
              Text(
                "User ID: ${user.id}",
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                user.email,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF8C8681),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
