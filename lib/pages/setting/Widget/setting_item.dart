import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef SettingsOptionClicked = void Function();

class SettingItem extends StatelessWidget {
  final String settingOptionText, selectedOption;
  final SettingsOptionClicked onOptionTapped;

  const SettingItem({
    super.key,
    required this.settingOptionText,
    required this.selectedOption,
    required this.onOptionTapped,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          settingOptionText,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: theme.colorScheme.onSecondary,
            fontSize: 25.sp, // ScreenUtil
            fontWeight: FontWeight.bold,
          ),
        ),

        GestureDetector(
          onTap: onOptionTapped,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30.w,   // بدل MediaQuery
              vertical: 16.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w),

            height: 50.h,       // بدل MediaQuery
            width: 1.sw,        // بدل mediaQuery.width

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: theme.primaryColor,
                width: 1.2.w,
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOption,
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontSize: 14.sp,
                    color: theme.primaryColor,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 24.sp,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
