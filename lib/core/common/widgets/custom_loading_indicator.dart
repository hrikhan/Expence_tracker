import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expense_tracker/core/utils/constants/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;

  const CustomLoadingIndicator({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 24.r,
        height: size ?? 24.r,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
          backgroundColor: AppColors.border.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
