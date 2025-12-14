import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnSelectedOption extends StatelessWidget {
  final String titleUnselectedOption;

  const UnSelectedOption({super.key, required this.titleUnselectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.black)),
      child: Text(titleUnselectedOption),
    );
  }
}
