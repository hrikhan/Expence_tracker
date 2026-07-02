import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/navigation_controller.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width > 1200) {
              // Desktop View: Expanded Sidebar + Active Page
              return Row(
                children: [
                  _buildSidebar(context),
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Color(0xFFEAE7E4),
                  ),
                  Expanded(
                    child: Obx(() => _pages[controller.currentIndex.value]),
                  ),
                ],
              );
            } else if (width >= 600) {
              // Tablet View: Compact Navigation Rail + Active Page
              return Row(
                children: [
                  Obx(() => NavigationRail(
                        selectedIndex: controller.currentIndex.value,
                        onDestinationSelected: controller.changeIndex,
                        backgroundColor: Colors.white,
                        selectedIconTheme: const IconThemeData(color: Color(0xFF231C18)),
                        unselectedIconTheme: const IconThemeData(color: Color(0xFF8C8681)),
                        selectedLabelTextStyle: GoogleFonts.inter(
                          color: const Color(0xFF231C18),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        unselectedLabelTextStyle: GoogleFonts.inter(
                          color: const Color(0xFF8C8681),
                          fontSize: 12.sp,
                        ),
                        labelType: NavigationRailLabelType.all,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.calendar_today_outlined),
                            selectedIcon: Icon(Icons.calendar_today),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.auto_awesome_outlined),
                            selectedIcon: Icon(Icons.auto_awesome),
                            label: Text('Sparkle'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.person_outline),
                            selectedIcon: Icon(Icons.person),
                            label: Text('Profile'),
                          ),
                        ],
                      )),
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Color(0xFFEAE7E4),
                  ),
                  Expanded(
                    child: Obx(() => _pages[controller.currentIndex.value]),
                  ),
                ],
              );
            } else {
              // Mobile View: Bottom Navigation Bar + FAB
              return Scaffold(
                backgroundColor: const Color(0xFFFAF8F6),
                body: Obx(() => _pages[controller.currentIndex.value]),
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: const Color(0xFF231C18),
                    shape: const CircleBorder(),
                    child: Icon(Icons.add, color: Colors.white, size: 24.r),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                bottomNavigationBar: _buildMobileBottomNavBar(),
              );
            }
          },
        ),
      ),
    );
  }

  // Sidebar for Desktop View
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 240.w,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "ExpenseTracker",
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          // Navigation Items
          _buildSidebarItem(
            index: 0,
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
            label: "Home",
          ),
          SizedBox(height: 12.h),
          _buildSidebarItem(
            index: 1,
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.auto_awesome,
            label: "Sparkle Insights",
          ),
          SizedBox(height: 12.h),
          _buildSidebarItem(
            index: 2,
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return InkWell(
        onTap: () => controller.changeIndex(index),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFAF8F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? const Color(0xFF231C18) : const Color(0xFF8C8681),
                size: 22.r,
              ),
              SizedBox(width: 16.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF231C18) : const Color(0xFF8C8681),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Bottom Navigation Bar for Mobile
  Widget _buildMobileBottomNavBar() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF231C18).withOpacity(0.04),
            blurRadius: 16.r,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home Tab
          _buildMobileTabItem(
            index: 0,
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
            label: "Home",
          ),
          // Sparkle Tab (Center round beige button)
          GestureDetector(
            onTap: () => controller.changeIndex(1),
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration: const BoxDecoration(
                color: Color(0xFFB09F92),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 24.r,
              ),
            ),
          ),
          // Profile Tab
          _buildMobileTabItem(
            index: 2,
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTabItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeIndex(index),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? const Color(0xFF231C18) : const Color(0xFF8C8681),
                size: 22.r,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF231C18) : const Color(0xFF8C8681),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
