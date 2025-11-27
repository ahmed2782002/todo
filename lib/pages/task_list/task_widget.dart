import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/provider/list_provider.dart';

import '../../core/firebase/task.dart';
import '../../core/theme/application_theme.dart';
import '../edit_task/edite_task.dart';

class TaskWidgetItem extends StatelessWidget {
  TaskWidgetItem({super.key, required this.task});

  final Task task;
  late final ListProvider provider;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    provider = Provider.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFE4A49),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (_) {
              Navigator.pushNamed(context, EditTask.routeName, arguments: task);
            },
            backgroundColor: Color(0xFF21B7CA),
            borderRadius: BorderRadius.circular(15),
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
                  .timeout(Duration(milliseconds: 200), onTimeout: () {
                provider.getAllTasksFromFireStore();
              });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(

            height: mediaQuery.height * 0.15,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.onBackground,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: task.isDone!
                        ? ApplicationTheme.isDoneColor
                        : theme.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: mediaQuery.width * 0.013,
                  height: mediaQuery.height * 0.1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            task.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: task.isDone!
                                ? TextStyle(
                                    color: ApplicationTheme.isDoneColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )
                                : theme.textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                    fontSize: 22,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          task.description ?? "",
                          maxLines: 2,
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
                          fontSize: 25,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          task.isDone = true;
                          provider.updateTask(task);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                          width: mediaQuery.width * 0.18,
                          height: mediaQuery.width * 0.08,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
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
