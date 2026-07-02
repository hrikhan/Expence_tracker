import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, size: 80.r, color: const Color(0xFFB09F92)),
            SizedBox(height: 16.h),
            Text(
              "Analytics & AI Sparkles",
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Discover spending patterns and optimization tips.",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF8C8681),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
