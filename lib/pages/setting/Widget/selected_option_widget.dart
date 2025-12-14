import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedOption extends StatelessWidget {
  final String selectedTitle;

  const SelectedOption({super.key, required this.selectedTitle});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedTitle),
          Icon(
            Icons.check,
            color: theme.colorScheme.onSecondary,
          )
        ],
      ),
    );
  }
}
