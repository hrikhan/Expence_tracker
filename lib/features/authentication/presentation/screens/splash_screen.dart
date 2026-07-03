import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../routes/app_routes.dart';
import 'package:expense_tracker/core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

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

    // Start the animation timeline
    _controller.forward();

    _navigateToLogin();
  }

  void _navigateToLogin() async {
    // Delay navigation to match animation timeline
    await Future.delayed(const Duration(milliseconds: 3200));
    if (StorageService.hasToken()) {
      Get.offNamed(AppRoute.getNavigationScreen());
    } else {
      Get.offNamed(AppRoute.getLoginScreen());
    }
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
      body: Center(
        child: FadeTransition(
          opacity: _logoFade,
          child: ScaleTransition(
            scale: _logoScale,
            child: SizedBox(
              width: 180.w,
              height: 180.h,
              child: Lottie.asset(
                'assets/lottie/everyday-logo-lottie.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
