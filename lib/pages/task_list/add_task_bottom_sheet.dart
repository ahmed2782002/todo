import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/firebase/firebase_utils.dart';
import 'package:to_do/core/firebase/task.dart';

import '../../core/provider/list_provider.dart';
import '../../l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late ListProvider listProvider;

  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    listProvider = Provider.of<ListProvider>(context);

    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(12),
      color: theme.colorScheme.onBackground.withOpacity(.98),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.add_new_task,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSecondary,
              )),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: theme.colorScheme.onSecondary),
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_task_title;
                        } else if (text.length < 4) {
                          return AppLocalizations.of(context)!
                              .your_task_title_must_be_at_least_4_characters;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.enter_task_title,
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSecondary.withOpacity(.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  theme.colorScheme.onSecondary.withOpacity(.5),
                              width: 1.2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF0739FF), width: 1.2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: theme.colorScheme.onSecondary),
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_task_description;
                        } else if (text.length < 6) {
                          return AppLocalizations.of(context)!
                              .your_task_Description_must_be_at_least_6_characters;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!
                            .enter_task_description,
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSecondary.withOpacity(.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  theme.colorScheme.onSecondary.withOpacity(.5),
                              width: 1.1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF0739FF), width: 1.1),
                        ),
                      ),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      AppLocalizations.of(context)!.select_time,
                      style: theme.textTheme.titleSmall!
                          .copyWith(color: theme.colorScheme.onSecondary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          DateFormat('dd-MM-yyyy').format(selectedDate),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: theme.primaryColor),
                        )),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(theme.primaryColor),
                    ),
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }

  void addTask() async {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectedDate,
      );

      print("🟢 Trying to add task to Firebase: ${task.title}, ${task.description}, ${task.dateTime}");

      try {
        // Add task
        await FirebaseUtils.addTaskToFirestore(task);
        print("✅ Task added successfully!");

        // Refresh tasks list
        await listProvider.getAllTasksFromFireStore();
        print("🔄 Task list refreshed from Firestore.");

        // Close bottom sheet
        Navigator.pop(context);
      } catch (e) {
        print("❌ Failed to add task: $e");
      }
    } else {
      print("⚠️ Form validation failed. Task not added.");
    }
  }


}
