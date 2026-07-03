import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/core/core.dart';
import 'package:expense_tracker/features/tracker/controllers/tracker_controller.dart';
import 'package:expense_tracker/features/profile/controllers/profile_controller.dart';
import '../widgets/dashboard_widgets.dart';
import '../widgets/add_transaction_bottom_sheet.dart';

class HomeScreen extends GetView<TrackerController> {
  const HomeScreen({super.key});

  Future<void> _handleRefresh() async {
    final profileController = Get.find<ProfileController>();
    if (controller.isTodaySelected.value) {
      await controller.getTodayTracker();
    } else {
      await controller.getOverallTracker();
    }
    await profileController.getProfile();
  }

  void _showAddExpenseBottomSheet(BuildContext context) {
    AddTransactionBottomSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Parent navigation shell handles the background
      floatingActionButton: FloatingActionButton(
        heroTag: 'home_fab',
        onPressed: () => _showAddExpenseBottomSheet(context),
        backgroundColor: const Color(0xFF231C18),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (width > 1200) {
            // Desktop Layout: 2-column layout (Balance Card on Left, History List on Right)
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardHeader(),
                    SizedBox(height: 32.h),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column
                          Expanded(
                            flex: 12,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SegmentSelector(),
                                  SizedBox(height: 24.h),
                                  const BalanceCard(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                          // Right Column
                          const Expanded(
                            flex: 15,
                            child: SingleChildScrollView(
                              child: HistoryList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (width >= 600) {
            // Tablet Layout: Centered single-column fluid layout
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 650),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: AppRefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    children: [
                      const DashboardHeader(),
                      SizedBox(height: 24.h),
                      const SegmentSelector(),
                      SizedBox(height: 20.h),
                      const BalanceCard(),
                      SizedBox(height: 24.h),
                      const HistoryList(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Mobile Layout: Standard vertical list
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: AppRefreshIndicator(
                onRefresh: _handleRefresh,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    const DashboardHeader(),
                    SizedBox(height: 20.h),
                    const SegmentSelector(),
                    SizedBox(height: 16.h),
                    const BalanceCard(),
                    SizedBox(height: 20.h),
                    const HistoryList(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
