import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do/pages/task_list/task_list_tab.dart';

import '../pages/setting/setting_view.dart';
import '../pages/task_list/add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  int selectedIndex = 0;

  List<Widget> pages = [
    TaskListTab(),
    const SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,

      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.onBackground,
        height: 78.h, // بدل mediaQuery.height * .093
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.r,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/list.png")),
              label: "List",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/setting.png")),
              label: "Setting",
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 32.sp,
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
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (_) => const AddTaskBottomSheet(),
    );
  }
}
