import 'package:flutter/material.dart';
import 'package:to_do/pages/task_list/task_list_tab.dart';

import '../pages/setting/setting_view.dart';
import '../pages/task_list/add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  int selectedIndex = 0;

  List<Widget> pages = [
    TaskListTab(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(

      body: pages[selectedIndex],
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.onBackground,
        height: mediaQuery.height * .093,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/list.png")),
                label: "List"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/setting.png")),
                label: "List")
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (_) => AddTaskBottomSheet());
  }
}
