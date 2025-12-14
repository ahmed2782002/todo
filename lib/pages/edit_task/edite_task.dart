import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/firebase/task.dart';

import '../../core/provider/list_provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "EditeTask";

  EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    Task task = ModalRoute.of(context)?.settings.arguments as Task;
    var theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(
                  task.title ?? "",
                  style: TextStyle(color: theme.colorScheme.onBackground),
                ),
                flexibleSpace: SizedBox(
                  height: 140.h, // بدل mediaQuery.height * .2
                ),
              )
            ],
          ),

          /// === Main Container ===
          Container(
            padding: EdgeInsets.all(20.r),
            margin: EdgeInsets.only(
              top: 110.h, // بدل mediaQuery.height * .13
              left: 30.w, // بدل mediaQuery.width * .1
              right: 30.w,
              bottom: 100.h, // بدل mediaQuery.height * .2
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: theme.colorScheme.onBackground,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 650.h, // بدل mediaQuery.height
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Edit Task",
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 25.h),

                      /// Title Field
                      TextFormField(
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 15.sp,
                        ),
                        initialValue: task.title,
                        decoration: InputDecoration(
                          hintText: "Enter title",
                          hintStyle: TextStyle(fontSize: 14.sp),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: theme.colorScheme.onSecondary,
                                width: 1.2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xFF0739FF), width: 1.2),
                          ),
                        ),
                        onChanged: (value) {
                          task.title = value;
                        },
                      ),
                      SizedBox(height: 25.h),

                      /// Description Field
                      TextFormField(
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 15.sp,
                        ),
                        initialValue: task.description,
                        decoration: InputDecoration(
                          hintText: "Enter description",
                          hintStyle: TextStyle(fontSize: 14.sp),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: theme.colorScheme.onSecondary,
                                width: 1.2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xFF0739FF), width: 1.2),
                          ),
                        ),
                        onChanged: (value) {
                          task.description = value;
                        },
                      ),
                      SizedBox(height: 25.h),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Select time :",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      InkWell(
                        onTap: () {
                          showCalendar(task);
                        },
                        child: Text(
                          "${task.dateTime!.day}-${task.dateTime!.month}-${task.dateTime!.year}",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffA9A9A99C).withOpacity(0.61),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      /// Save Btn
                      SizedBox(
                        width: 200.w,
                        height: 45.h,
                        child: ElevatedButton(
                          onPressed: () {
                            listProvider.updateTask(task);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCalendar(Task task) async {
    task.dateTime = await showDatePicker(
      context: context,
      initialDate: task.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ) ??
        task.dateTime;
    setState(() {});
  }
}
