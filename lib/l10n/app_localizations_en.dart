// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tasks';

  @override
  String get add_new_task => 'Add New Task';

  @override
  String get please_enter_task_title => 'Please enter task title';

  @override
  String get your_task_title_must_be_at_least_4_characters => 'Your task title must be at least 4 characters';

  @override
  String get enter_task_title => 'Enter task title';

  @override
  String get please_enter_task_description => 'Please enter task description';

  @override
  String get your_task_Description_must_be_at_least_6_characters => 'Your task description must be at least 6 characters';

  @override
  String get enter_task_description => 'Enter task description';

  @override
  String get select_time => 'Select Time';

  @override
  String get add => 'Add';

  @override
  String get theme_Mode => 'Theme Mode';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';
}
