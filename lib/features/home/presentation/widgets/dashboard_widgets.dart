import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:expense_tracker/core/core.dart';
import 'package:expense_tracker/features/tracker/controllers/tracker_controller.dart';
import 'package:expense_tracker/features/profile/controllers/profile_controller.dart';
import 'add_transaction_bottom_sheet.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good morning,";
    } else if (hour >= 12 && hour < 17) {
      return "Good afternoon,";
    } else {
      return "Good evening,";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Rounded Profile Avatar
        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.border,
          child: Icon(Icons.person, size: 24.r, color: AppColors.primary),
        ),
        SizedBox(width: 12.w),
        // Greeting Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textSecondary,
                ),
              ),
              Obx(() {
                final profileController = Get.find<ProfileController>();
                if (profileController.isLoading.value) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  final baseColor = isDark ? Colors.grey[800]! : const Color(0xFFF3F1EE);
                  final highlightColor = isDark ? Colors.grey[700]! : const Color(0xFFEAE7E4);

                  return Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 100.w,
                      height: 18.h,
                      margin: EdgeInsets.only(top: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  );
                }

                final user = profileController.profile.value;
                final email = user?.email ?? "User";
                final name = email.split('@')[0];
                final capitalized = name.isNotEmpty
                    ? name[0].toUpperCase() + name.substring(1)
                    : "User";

                return ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF231C18), Color(0xFF8A7665)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    capitalized,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        // Language Selector
        GestureDetector(
          onTap: () async {
            if (Get.locale?.languageCode == 'en') {
              Get.updateLocale(const Locale('bn', 'BD'));
              await StorageService.saveLanguage('bn', 'BD');
            } else {
              Get.updateLocale(const Locale('en', 'US'));
              await StorageService.saveLanguage('en', 'US');
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.border.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.public, size: 16.r, color: AppColors.primary),
                SizedBox(width: 4.w),
                Text(
                  Get.locale?.languageCode.toUpperCase() ?? 'EN',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 4.w),
        // Swap Action Icon
        IconButton(
          onPressed: () async {
            if (Get.locale?.languageCode == 'en') {
              Get.updateLocale(const Locale('bn', 'BD'));
              await StorageService.saveLanguage('bn', 'BD');
            } else {
              Get.updateLocale(const Locale('en', 'US'));
              await StorageService.saveLanguage('en', 'US');
            }
          },
          icon: Icon(Icons.swap_horiz, size: 24.r, color: AppColors.primary),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(40.w, 40.h),
          ),
        ),
      ],
    );
  }
}

class SegmentSelector extends StatelessWidget {
  const SegmentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrackerController>();

    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Obx(() {
        final isToday = controller.isTodaySelected.value;
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeSegment(true),
                child: Container(
                  margin: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: isToday ? AppColors.primary : AppColors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.today.tr,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isToday ? AppColors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeSegment(false),
                child: Container(
                  margin: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: !isToday ? AppColors.primary : AppColors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.overall.tr,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: !isToday ? AppColors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrackerController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const BalanceCardShimmer();
      }

      final bal = controller.balance.value;
      final inc = controller.totalIncome.value;
      final exp = controller.totalExpense.value;

      double progress = 0.0;
      if (inc > 0) {
        progress = (exp / inc).clamp(0.0, 1.0);
      } else if (exp > 0) {
        progress = 1.0;
      }

      return Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF231C18).withOpacity(0.04),
              blurRadius: 16.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.isTodaySelected.value
                  ? "CURRENT DAY BALANCE"
                  : "OVERALL BALANCE",
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: const Color(0xFF8C8681),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "${bal < 0 ? '-' : ''}৳${bal.abs().toStringAsFixed(2)}",
              style: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF231C18),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                // Income
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_downward, size: 14.r, color: const Color(0xFF8A7665)),
                          SizedBox(width: 4.w),
                          Text(
                            "INCOME",
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8C8681),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "+৳${inc.toStringAsFixed(2)}",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF8A7665),
                        ),
                      ),
                    ],
                  ),
                ),
                // Expenses
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_upward, size: 14.r, color: const Color(0xFFC84C4C)),
                          SizedBox(width: 4.w),
                          Text(
                            "EXPENSES",
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8C8681),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "-৳${exp.toStringAsFixed(2)}",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFC84C4C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // Custom Rounded Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: const Color(0xFFEAE7E4),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB09F92)),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class BalanceCardShimmer extends StatelessWidget {
  const BalanceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrackerController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : const Color(0xFFF3F1EE);
    final highlightColor = isDark ? Colors.grey[700]! : const Color(0xFFEAE7E4);

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF231C18).withOpacity(0.04),
            blurRadius: 16.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            controller.isTodaySelected.value
                ? "CURRENT DAY BALANCE"
                : "OVERALL BALANCE",
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: const Color(0xFF8C8681),
            ),
          )),
          SizedBox(height: 8.h),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 160.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              // Income
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_downward, size: 14.r, color: const Color(0xFF8A7665)),
                        SizedBox(width: 4.w),
                        Text(
                          "INCOME",
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF8C8681),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        width: 80.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expenses
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_upward, size: 14.r, color: const Color(0xFFC84C4C)),
                        SizedBox(width: 4.w),
                        Text(
                          "EXPENSES",
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF8C8681),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        width: 80.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: double.infinity,
              height: 6.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryListShimmer extends StatelessWidget {
  const HistoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : const Color(0xFFF3F1EE);
    final highlightColor = isDark ? Colors.grey[700]! : const Color(0xFFEAE7E4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            Container(
              width: 60.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final colors = [
              const Color(0xFF8A7665),
              const Color(0xFFC84C4C),
              AppColors.primary,
            ];
            final iconColor = colors[index % colors.length];

            return Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF231C18).withOpacity(0.02),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: iconColor.withValues(alpha: 0.8),
                    highlightColor: iconColor,
                    child: Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        index % 2 == 0 ? Icons.arrow_downward : Icons.arrow_upward,
                        color: Colors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            width: 140.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 60.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrackerController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const HistoryListShimmer();
      }
      final trackers = controller.trackers;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                controller.isTodaySelected.value
                    ? AppStrings.historyOfToday.tr
                    : AppStrings.overallHistory.tr,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              )),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAE7E4).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    "See All",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF231C18),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (trackers.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  AppStrings.noTransactions.tr,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: trackers.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final tx = trackers[index];
                final isInc = tx.type == "INCOME";
                final amountString = isInc ? "+৳${tx.cost.toStringAsFixed(2)}" : "-৳${tx.cost.toStringAsFixed(2)}";
                final iconData = isInc ? Icons.arrow_downward : Icons.arrow_upward;
                final iconBg = isInc ? const Color(0xFF8A7665) : const Color(0xFFC84C4C);

                return GestureDetector(
                  onTap: () {
                    AddTransactionBottomSheet.show(context, item: tx);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF231C18).withOpacity(0.02),
                          blurRadius: 8.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: iconBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(iconData, color: Colors.white, size: 20.r),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.title,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF231C18),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${isInc ? "Income" : "Expense"} • ${tx.date}",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF8C8681),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          amountString,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isInc ? const Color(0xFF8A7665) : const Color(0xFFC84C4C),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}
