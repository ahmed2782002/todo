import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/pages/task_list/task_widget.dart';
import '../../core/provider/list_provider.dart';
import '../../l10n/app_localizations.dart';
import 'horizontal_date_picker.dart';

class TaskListTab extends StatefulWidget {
  TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // تأجيل تنفيذ init بعد انتهاء build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var listProvider = Provider.of<ListProvider>(context, listen: false);
      listProvider.init(); // تهيئة الإعدادات
      listProvider.getAllTasksFromFireStore(); // جلب المهام
      _scrollToToday(); // تمرير إلى اليوم الحالي
    });
  }

  // تمرير الى اليوم الحالي في الهوريزونتال ديت بيكر
  void _scrollToToday() {
    final now = DateTime.now();
    final first = DateTime.now(); // بداية اليوم الحالي

    int index = now.difference(first).inDays;
    double position = index * 86.w; // عرض العنصر + margin مع ScreenUtil

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          alignment: Alignment(0, 2.4),
          children: [
            Container(
              color: theme.primaryColor,
              width: 1.sw, // full screen width
              height: 0.21.sh, // 21% of screen height
              child: Padding(
                padding: EdgeInsets.all(30.0.sp),
                child: Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: HorizontalDatePicker(
                scrollController: _scrollController,
                initialDate: listProvider.selectDate,
                firstDate: DateTime.now(), // يبدأ من اليوم الحالي
                lastDate: DateTime(DateTime.now().year, 12, 31), // باقي السنة
              ),
            ),
          ],
        ),
        SizedBox(height: 0.04.sh),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) {
              return TaskWidgetItem(task: listProvider.tasksList[index]);
            },
          ),
        ),
      ],
    );
  }
}
