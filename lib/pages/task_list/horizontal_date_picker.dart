import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/provider/list_provider.dart';

class HorizontalDatePicker extends StatelessWidget {
  final ScrollController scrollController;

  const HorizontalDatePicker({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listProvider = Provider.of<ListProvider>(context);
    final today = DateTime.now();

    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // كل index يولد يوم جديد بعد اليوم الحالي
          final date = today.add(Duration(days: index));

          final isActive = date.year == listProvider.selectDate.year &&
              date.month == listProvider.selectDate.month &&
              date.day == listProvider.selectDate.day;

          final isToday = date.year == today.year &&
              date.month == today.month &&
              date.day == today.day;

          bool highlight = false;
          if (listProvider.isFirstOpen && isToday) {
            highlight = true; // أول مرة فقط
          } else if (isActive) {
            highlight = true; // اليوم المختار بعد ذلك
          }

          return GestureDetector(
            onTap: () => listProvider.changeDate(date),
            child: Container(
              width: 70.w,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: highlight
                    ? theme.colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _monthName(date.month),
                    style: TextStyle(
                      color: highlight ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: highlight ? Colors.white : Colors.black87,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
      "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"
    ];
    return months[month - 1];
  }
}
