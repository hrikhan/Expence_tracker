import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/core/core.dart';
import 'package:expense_tracker/features/tracker/controllers/tracker_controller.dart';
import '../widgets/dashboard_widgets.dart';

class HomeScreen extends GetView<TrackerController> {
  const HomeScreen({super.key});

  void _showAddExpenseBottomSheet(BuildContext context) {
    controller.clearForm();
    controller.dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 24.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF231C18).withOpacity(0.08),
              blurRadius: 20.r,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add Transaction",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              
              // Title Field
              Text(
                "Title",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: controller.titleController,
                hintText: "Enter title (e.g. Starbucks)",
              ),
              SizedBox(height: 16.h),

              // Cost Field
              Text(
                "Amount",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: controller.costController,
                hintText: "Enter amount (e.g. 45.50)",
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16.h),

              // Date Field (With DatePicker)
              Text(
                "Date",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF231C18),
                            onPrimary: Colors.white,
                            onSurface: Color(0xFF231C18),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: controller.dateController,
                    hintText: "Select date",
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Type Selector
              Text(
                "Type",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
              ),
              SizedBox(height: 8.h),
              Obx(() => Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAE7E4),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectedType.value = "EXPENSE",
                            child: Container(
                              margin: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: controller.selectedType.value == "EXPENSE"
                                    ? const Color(0xFF231C18)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "EXPENSE",
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: controller.selectedType.value == "EXPENSE"
                                      ? Colors.white
                                      : const Color(0xFF8C8681),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectedType.value = "INCOME",
                            child: Container(
                              margin: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: controller.selectedType.value == "INCOME"
                                    ? const Color(0xFF8A7665)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "INCOME",
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: controller.selectedType.value == "INCOME"
                                      ? Colors.white
                                      : const Color(0xFF8C8681),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 32.h),

              // Submit Button
              Obx(() => CustomButton(
                    text: "Add Transaction",
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      final success = await controller.addTracker();
                      if (success) {
                        Get.back();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Parent navigation shell handles the background
      floatingActionButton: FloatingActionButton(
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
                child: ListView(
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
            );
          } else {
            // Mobile Layout: Standard vertical list
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ListView(
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
            );
          }
        },
      ),
    );
  }
}
