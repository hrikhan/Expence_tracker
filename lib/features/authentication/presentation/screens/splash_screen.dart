import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _subtitleFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _subtitleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    // Start the animation timeline
    _controller.forward();

    _navigateToLogin();
  }

  void _navigateToLogin() async {
    // Delay navigation to match animation timeline
    await Future.delayed(const Duration(milliseconds: 3200));
    Get.offNamed(AppRoute.getLoginScreen());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F6), // Matches the warm off-white app background
      body: Stack(
        children: [
          // Centered App Logo and Title with Staggered Animations
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Elastic Scale and Fade Logo
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      width: 96.w,
                      height: 96.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF231C18),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF231C18).withOpacity(0.12),
                            blurRadius: 24.r,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 44.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                // Slide and Fade App Brand Name
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: Text(
                      "every day",
                      style: GoogleFonts.inter(
                        fontSize: 38.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF231C18),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                // Fade Subtitle
                FadeTransition(
                  opacity: _subtitleFade,
                  child: Text(
                    "track & optimize your budget",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB09F92),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Subtle progress loader at the bottom
          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: Center(
              child: FadeTransition(
                opacity: _subtitleFade,
                child: SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB09F92)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
