import 'package:flutter/material.dart';
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
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            AppBar(
              title: Text(task.title ?? "",
                  style: TextStyle(color: theme.colorScheme.onBackground)),
              flexibleSpace: SizedBox(
                height: mediaQuery.height * .2,
              ),
            )
          ]),
          Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(
                  top: mediaQuery.height * .13,
                  left: mediaQuery.width * .1,
                  right: mediaQuery.width * .1,
                  bottom: mediaQuery.height * .2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: theme.colorScheme.onBackground),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: mediaQuery.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mediaQuery.height * .02,
                        ),
                        Text(
                          "Edit Task",
                          style: TextStyle(
                              color: theme.colorScheme.onSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .04,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: theme.colorScheme.onSecondary,
                          ),
                          initialValue: task.title,
                          decoration: InputDecoration(
                            hintText: "Enter title",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: theme.colorScheme.onSecondary,
                                  width: 1.2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF0739FF), width: 1.2),
                            ),
                          ),
                          onChanged: (value) {
                            task.title = value;
                          },
                        ),
                        SizedBox(
                          height: mediaQuery.height * .04,
                        ),
                        TextFormField(
                          style:
                              TextStyle(color: theme.colorScheme.onSecondary),
                          initialValue: task.description,
                          decoration: InputDecoration(
                            hintText: "Enter description",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: theme.colorScheme.onSecondary,
                                  width: 1.2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF0739FF), width: 1.2),
                            ),
                          ),
                          onChanged: (value) {
                            task.description = value;
                          },
                        ),
                        SizedBox(
                          height: mediaQuery.height * .04,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Select time :",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * .01),
                        InkWell(
                          onTap: () {
                            showCalendar(task);
                          },
                          child: Text(
                            "${task.dateTime!.day}-${task.dateTime!.month}-${task.dateTime!.year}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffA9A9A99C).withOpacity(0.61),
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * .04),
                        Container(
                          width: mediaQuery.width * .6,
                          height: mediaQuery.height * .05,
                          child: ElevatedButton(
                            onPressed: () {
                              listProvider.updateTask(task);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void showCalendar(Task task) async {
    task.dateTime = await showDatePicker(
            context: context,
            initialDate: task.dateTime,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        task.dateTime;
    setState(() {});
  }
}
