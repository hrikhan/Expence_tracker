import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Rounded Profile Avatar
        CircleAvatar(
          radius: 22.r,
          backgroundColor: const Color(0xFFEAE7E4),
          backgroundImage: const NetworkImage(
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
          ),
          onBackgroundImageError: (_, __) {},
          child: Icon(Icons.person, size: 24.r, color: const Color(0xFF231C18)),
        ),
        SizedBox(width: 12.w),
        // Greeting Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning,",
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF8C8681),
                ),
              ),
              Text(
                "User",
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF231C18),
                ),
              ),
            ],
          ),
        ),
        // Language Selector
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFEAE7E4).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Icon(Icons.public, size: 16.r, color: const Color(0xFF231C18)),
              SizedBox(width: 4.w),
              Text(
                "EN",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF231C18),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        // Swap Action Icon
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.swap_horiz, size: 24.r, color: const Color(0xFF231C18)),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(40.w, 40.h),
          ),
        ),
      ],
    );
  }
}

class SegmentSelector extends StatefulWidget {
  const SegmentSelector({super.key});

  @override
  State<SegmentSelector> createState() => _SegmentSelectorState();
}

class _SegmentSelectorState extends State<SegmentSelector> {
  bool isToday = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F6),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFEAE7E4), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isToday = true),
              child: Container(
                margin: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF231C18) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Today",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isToday ? Colors.white : const Color(0xFF8C8681),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isToday = false),
              child: Container(
                margin: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: !isToday ? const Color(0xFF231C18) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Overall",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: !isToday ? Colors.white : const Color(0xFF8C8681),
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

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            "CURRENT DAY BALANCE",
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: const Color(0xFF8C8681),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "\$1,240.00",
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
                      "+\$2,100",
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
                      "-\$860",
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
              value: 0.6,
              minHeight: 6.h,
              backgroundColor: const Color(0xFFEAE7E4),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB09F92)),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      _TransactionItem(
        title: "Starbucks Coffee",
        category: "Food & Drink",
        time: "08:45 AM",
        amount: "-\$12.50",
        isIncome: false,
        iconData: Icons.local_cafe_outlined,
        iconBg: const Color(0xFF231C18),
      ),
      _TransactionItem(
        title: "Project Bonus",
        category: "Work",
        time: "10:30 AM",
        amount: "+\$1,500.00",
        isIncome: true,
        iconData: Icons.wallet_outlined,
        iconBg: const Color(0xFFB09F92),
      ),
      _TransactionItem(
        title: "Uber Ride",
        category: "Transport",
        time: "12:15 PM",
        amount: "-\$24.80",
        isIncome: false,
        iconData: Icons.directions_car_outlined,
        iconBg: const Color(0xFF231C18),
      ),
      _TransactionItem(
        title: "Whole Foods Market",
        category: "Groceries",
        time: "05:40 PM",
        amount: "-\$37.20",
        isIncome: false,
        iconData: Icons.local_grocery_store_outlined,
        iconBg: const Color(0xFF231C18),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "History of Today",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF231C18),
              ),
            ),
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final tx = transactions[index];
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
                  // Circular Icon Container
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: tx.iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(tx.iconData, color: Colors.white, size: 20.r),
                  ),
                  SizedBox(width: 12.w),
                  // Title and Subtitle
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
                          "${tx.category} • ${tx.time}",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFF8C8681),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Amount
                  Text(
                    tx.amount,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: tx.isIncome ? const Color(0xFF8A7665) : const Color(0xFFC84C4C),
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

class _TransactionItem {
  final String title;
  final String category;
  final String time;
  final String amount;
  final bool isIncome;
  final IconData iconData;
  final Color iconBg;

  _TransactionItem({
    required this.title,
    required this.category,
    required this.time,
    required this.amount,
    required this.isIncome,
    required this.iconData,
    required this.iconBg,
  });
}
