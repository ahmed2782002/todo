import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/provider/list_provider.dart';

import '../../core/firebase/task.dart';
import '../../core/theme/application_theme.dart';
import '../edit_task/edite_task.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskWidgetItem extends StatelessWidget {
  TaskWidgetItem({super.key, required this.task});

  final Task task;
  late final ListProvider provider;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    provider = Provider.of<ListProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFFFE4A49),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (_) {
              Navigator.pushNamed(context, EditTask.routeName, arguments: task);
            },
            backgroundColor: const Color(0xFF21B7CA),
            borderRadius: BorderRadius.circular(15.r),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (_) {
              FirebaseFirestore.instance
                  .collection(Task.collectionName)
                  .doc(task.id)
                  .delete()
                  .timeout(const Duration(milliseconds: 200), onTimeout: () {
                provider.getAllTasksFromFireStore();
              });
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Container(
            height: 0.17.sh, // زيادة ارتفاع الكارد عشان تكفي 3 سطور
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.onBackground,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: task.isDone!
                        ? ApplicationTheme.isDoneColor
                        : theme.primaryColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  width: 0.013.sw,
                  height: 0.1.sh,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Text(
                          task.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: task.isDone!
                              ? TextStyle(
                            color: ApplicationTheme.isDoneColor,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          )
                              : theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5.h,
                          left: 10.w,
                          right: 10.w,
                          bottom: 10.h,
                        ),
                        child: Text(
                          task.description ?? "",
                          maxLines: 2, // بدل 2 → 3 سطور
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: theme.colorScheme.onSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
                task.isDone!
                    ? Text(
                  "Done!",
                  style: TextStyle(
                    color: ApplicationTheme.isDoneColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                )
                    : InkWell(
                  onTap: () {
                    task.isDone = true;
                    provider.updateTask(task);
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 7.h, horizontal: 20.w),
                    width: 0.18.sw,
                    height: 0.08.sw,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.asset("assets/images/img.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
