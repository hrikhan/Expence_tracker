import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/core/core.dart';

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
      backgroundColor: AppColors.background,
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
                    color: AppColors.border,
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
                        backgroundColor: AppColors.white,
                        selectedIconTheme: const IconThemeData(color: AppColors.primary),
                        unselectedIconTheme: const IconThemeData(color: AppColors.textSecondary),
                        selectedLabelTextStyle: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        unselectedLabelTextStyle: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp,
                        ),
                        labelType: NavigationRailLabelType.all,
                        destinations: [
                          NavigationRailDestination(
                            icon: const Icon(Icons.wallet_outlined),
                            selectedIcon: const Icon(Icons.wallet),
                            label: Text(AppStrings.home.tr),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.auto_awesome_outlined),
                            selectedIcon: const Icon(Icons.auto_awesome),
                            label: Text(AppStrings.sparkle.tr),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.person_outline),
                            selectedIcon: const Icon(Icons.person),
                            label: Text(AppStrings.profile.tr),
                          ),
                        ],
                      )),
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: AppColors.border,
                  ),
                  Expanded(
                    child: Obx(() => _pages[controller.currentIndex.value]),
                  ),
                ],
              );
            } else {
              // Mobile View: Bottom Navigation Bar + FAB
              return Scaffold(
                backgroundColor: AppColors.background,
                body: Obx(() => _pages[controller.currentIndex.value]),
                floatingActionButton: Obx(() {
                  final isSelected = controller.currentIndex.value == 1;
                  return FloatingActionButton(
                    heroTag: 'navigation_fab',
                    onPressed: () => controller.changeIndex(1),
                    backgroundColor: isSelected ? AppColors.primary : AppColors.accent,
                    shape: const CircleBorder(),
                    child: Icon(Icons.auto_awesome, color: AppColors.white, size: 24.r),
                  );
                }),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              AppStrings.appName.tr,
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          // Navigation Items
          _buildSidebarItem(
            index: 0,
            icon: Icons.wallet_outlined,
            activeIcon: Icons.wallet,
            label: AppStrings.home.tr,
          ),
          SizedBox(height: 12.h),
          _buildSidebarItem(
            index: 1,
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.auto_awesome,
            label: AppStrings.sparkleInsights.tr,
          ),
          SizedBox(height: 12.h),
          _buildSidebarItem(
            index: 2,
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: AppStrings.profile.tr,
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
            color: isSelected ? AppColors.background : AppColors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 22.r,
              ),
              SizedBox(width: 16.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
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
    return BottomAppBar(
      color: AppColors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.04),
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
              icon: Icons.wallet_outlined,
              activeIcon: Icons.wallet,
              label: AppStrings.home.tr,
            ),
            // Spacing placeholder for docked FAB
            SizedBox(width: 48.w),
            // Profile Tab
            _buildMobileTabItem(
              index: 2,
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: AppStrings.profile.tr,
            ),
          ],
        ),
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
          color: AppColors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 22.r,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
