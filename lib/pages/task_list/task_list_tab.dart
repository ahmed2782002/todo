import 'package:flutter/material.dart';
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

  void _scrollToToday() {
    final now = DateTime.now();
    final first = DateTime.now().subtract(const Duration(days: 365));

    int index = now.difference(first).inDays;
    double position = index * 86; // تقريبًا عرض العنصر + margin

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
    var mediaQuery = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          alignment: const Alignment(0, 2.4),
          children: [
            Container(
              color: theme.primaryColor,
              width: double.infinity,
              height: mediaQuery.height * .21,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: HorizontalDatePicker(
                scrollController: _scrollController,
                initialDate: listProvider.selectDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ),
            ),
          ],
        ),
        SizedBox(height: mediaQuery.height * .04),
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

