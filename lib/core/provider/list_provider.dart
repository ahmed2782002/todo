import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/core/provider/prefs_helper.dart';
import '../firebase/firebase_utils.dart';
import '../firebase/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  bool isLoading = false;

  DateTime selectDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  bool isFirstOpen = true;
  ThemeMode currentTheme = ThemeMode.light;
  String currentLocale = "en";
  ScrollController? _scrollController;

  void setScrollController(ScrollController controller) {
    _scrollController = controller;
  }

  Future<void> getAllTasksFromFireStore() async {
    isLoading = true;
    notifyListeners();

    QuerySnapshot<Task> querySnapshot =
    await FirebaseUtils.getTaskCollection().get();

    List<Task> allTasks =
    querySnapshot.docs.map((doc) => doc.data()).toList();

    tasksList = allTasks.where((task) {
      if (task.dateTime == null) return false;
      return task.dateTime!.day == selectDate.day &&
          task.dateTime!.month == selectDate.month &&
          task.dateTime!.year == selectDate.year;
    }).toList();

    tasksList.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

    isLoading = false;
    notifyListeners();

    // Scroll to last item
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController != null && _scrollController!.hasClients) {
        _scrollController!.animateTo(
          _scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void addTaskImmediately(Task task) {
    if (task.dateTime != null &&
        task.dateTime!.day == selectDate.day &&
        task.dateTime!.month == selectDate.month &&
        task.dateTime!.year == selectDate.year) {
      tasksList.add(task);
      tasksList.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    }
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    selectDate = DateTime(newDate.year, newDate.month, newDate.day);
    isFirstOpen = false;
    getAllTasksFromFireStore();
  }

  void updateTask(Task task) async {
    await FirebaseUtils.getTaskCollection()
        .doc(task.id)
        .update(task.toFireStore());

    await getAllTasksFromFireStore();
    notifyListeners();
  }

  void init() async {
    String mode = PrefsHelper.getMode();
    changeTheme(mode == "dark" ? ThemeMode.dark : ThemeMode.light);

    String? newLang = PrefsHelper.getLanguage();
    changeLocal(newLang ?? "en");

    selectDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    isFirstOpen = true;
    await getAllTasksFromFireStore();
  }

  void changeTheme(ThemeMode newTheme) {
    PrefsHelper.saveTheme(newTheme == ThemeMode.dark ? "dark" : "light");
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeLocal(String newLocale) {
    currentLocale = newLocale;
    PrefsHelper.saveLanguage(newLocale);
    notifyListeners();
  }

  String splashScreen() {
    return currentTheme == ThemeMode.dark
        ? "assets/images/splash_screen_dark.png"
        : "assets/images/splash_screen.png";
  }

  bool isDarkEnabled() => currentTheme == ThemeMode.dark;
}
