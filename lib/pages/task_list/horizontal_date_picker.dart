import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/list_provider.dart';

class HorizontalDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ScrollController scrollController;

  const HorizontalDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listProvider = Provider.of<ListProvider>(context);

    List<DateTime> dates = [];
    for (int i = 0; i <= lastDate.difference(firstDate).inDays; i++) {
      dates.add(firstDate.add(Duration(days: i)));
    }

    return SizedBox(
      height: 110,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];

          final isActive = date.year == listProvider.selectDate.year &&
              date.month == listProvider.selectDate.month &&
              date.day == listProvider.selectDate.day;

          final isToday = date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day;

          bool highlight = false;
          if (listProvider.isFirstOpen && isToday) {
            highlight = true; // أول مرة فقط
          } else if (isActive) {
            highlight = true; // اليوم المختار بعد ذلك
          }

          return GestureDetector(
            onTap: () => listProvider.changeDate(date),
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: highlight
                    ? theme.colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _monthName(date.month),
                    style: TextStyle(
                      color: highlight ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: highlight ? Colors.white : Colors.black87,
                      fontSize: 22,
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
