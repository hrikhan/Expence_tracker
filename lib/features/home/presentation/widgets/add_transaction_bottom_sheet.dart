import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/core/core.dart';
import 'package:expense_tracker/features/tracker/controllers/tracker_controller.dart';
import 'package:expense_tracker/features/tracker/data/models/tracker_model.dart';

class AddTransactionBottomSheet extends StatelessWidget {
  final TrackerModel? item;

  const AddTransactionBottomSheet({super.key, this.item});

  static void show(BuildContext context, {TrackerModel? item}) {
    final controller = Get.find<TrackerController>();
    if (item != null) {
      controller.setFormForEdit(item);
    } else {
      controller.clearForm();
      controller.dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }

    final size = MediaQuery.of(context).size;
    final isDesktopOrWeb = kIsWeb || size.width > 600;

    if (isDesktopOrWeb) {
      Get.dialog(
        AddTransactionBottomSheet(item: item),
        barrierDismissible: true,
      );
    } else {
      Get.bottomSheet(
        AddTransactionBottomSheet(item: item),
        isScrollControlled: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrackerController>();
    final size = MediaQuery.of(context).size;
    final isDesktopOrWeb = kIsWeb || size.width > 600;

    Widget content = Container(
      width: isDesktopOrWeb ? 460 : double.infinity,
      padding: EdgeInsets.only(
        left: isDesktopOrWeb ? 24 : 20.w,
        right: isDesktopOrWeb ? 24 : 20.w,
        top: isDesktopOrWeb ? 24 : 24.h,
        bottom: isDesktopOrWeb ? 24 : (MediaQuery.of(context).viewInsets.bottom + 24.h),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F6),
        borderRadius: isDesktopOrWeb
            ? BorderRadius.circular(24)
            : BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF231C18).withOpacity(0.08),
            blurRadius: isDesktopOrWeb ? 16 : 20.r,
            offset: isDesktopOrWeb ? const Offset(0, 8) : const Offset(0, -4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48), // Spacer to balance the layout
                Expanded(
                  child: Text(
                    item != null ? "Edit Transaction" : "Add Transaction",
                    style: GoogleFonts.inter(
                      fontSize: isDesktopOrWeb ? 20 : 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF231C18),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                item != null
                    ? IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: const Color(0xFFC84C4C),
                          size: isDesktopOrWeb ? 24 : 24.r,
                        ),
                        onPressed: () async {
                          final confirm = await Get.dialog<bool>(
                            AlertDialog(
                              title: const Text("Delete Transaction"),
                              content: const Text("Are you sure you want to delete this transaction?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text("Delete", style: TextStyle(color: Color(0xFFC84C4C))),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            final success = await controller.deleteTracker(item!.id);
                            if (success && context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                      )
                    : const SizedBox(width: 48),
              ],
            ),
            SizedBox(height: isDesktopOrWeb ? 24 : 24.h),
            
            // Title Field
            Text(
              "Title",
              style: GoogleFonts.inter(
                fontSize: isDesktopOrWeb ? 12 : 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
            SizedBox(height: isDesktopOrWeb ? 8 : 8.h),
            CustomTextField(
              controller: controller.titleController,
              hintText: "Enter title (e.g. Starbucks)",
            ),
            SizedBox(height: isDesktopOrWeb ? 16 : 16.h),

            // Cost Field
            Text(
              "Amount",
              style: GoogleFonts.inter(
                fontSize: isDesktopOrWeb ? 12 : 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
            SizedBox(height: isDesktopOrWeb ? 8 : 8.h),
            CustomTextField(
              controller: controller.costController,
              hintText: "${AppStrings.ammountHint} (e.g. 45,50)",
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: isDesktopOrWeb ? 16 : 16.h),

            // Date Field (With DatePicker)
            Text(
              "Date",
              style: GoogleFonts.inter(
                fontSize: isDesktopOrWeb ? 12 : 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
            SizedBox(height: isDesktopOrWeb ? 8 : 8.h),
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
            SizedBox(height: isDesktopOrWeb ? 16 : 16.h),

            // Type Selector
            Text(
              "Type",
              style: GoogleFonts.inter(
                fontSize: isDesktopOrWeb ? 12 : 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
            SizedBox(height: isDesktopOrWeb ? 8 : 8.h),
            Obx(() => Container(
                  height: isDesktopOrWeb ? 48 : 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAE7E4),
                    borderRadius: BorderRadius.circular(isDesktopOrWeb ? 12 : 12.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedType.value = "EXPENSE",
                          child: Container(
                            margin: EdgeInsets.all(isDesktopOrWeb ? 4 : 4.r),
                            decoration: BoxDecoration(
                              color: controller.selectedType.value == "EXPENSE"
                                  ? const Color(0xFF231C18)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(isDesktopOrWeb ? 8 : 8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "EXPENSE",
                              style: GoogleFonts.inter(
                                fontSize: isDesktopOrWeb ? 13 : 13.sp,
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
                            margin: EdgeInsets.all(isDesktopOrWeb ? 4 : 4.r),
                            decoration: BoxDecoration(
                              color: controller.selectedType.value == "INCOME"
                                  ? const Color(0xFF8A7665)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(isDesktopOrWeb ? 8 : 8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "INCOME",
                              style: GoogleFonts.inter(
                                fontSize: isDesktopOrWeb ? 13 : 13.sp,
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
            SizedBox(height: isDesktopOrWeb ? 32 : 32.h),

            // Submit Button
            Obx(() => CustomButton(
                  text: item != null ? "Update Transaction" : "Add Transaction",
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    final success = item != null
                        ? await controller.updateTracker(item!.id)
                        : await controller.addTracker();
                    if (success) {
                      if (item != null && context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                )),
          ],
        ),
      ),
    );

    if (isDesktopOrWeb) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: content,
      );
    }
    return content;
  }
}
