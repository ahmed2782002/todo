// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'المهام';

  @override
  String get add_new_task => 'أضف مهمة جديدة';

  @override
  String get please_enter_task_title => 'يرجى إدخال عنوان المهمة';

  @override
  String get your_task_title_must_be_at_least_4_characters => 'يجب أن يكون عنوان المهمة 4 أحرف على الأقل';

  @override
  String get enter_task_title => 'أدخل عنوان المهمة';

  @override
  String get please_enter_task_description => 'يرجى إدخال وصف المهمة';

  @override
  String get your_task_Description_must_be_at_least_6_characters => 'يجب أن يكون وصف المهمة 6 أحرف على الأقل';

  @override
  String get enter_task_description => 'أدخل وصف المهمة';

  @override
  String get select_time => 'اختر الوقت';

  @override
  String get add => 'أضف';

  @override
  String get theme_Mode => 'النمط';

  @override
  String get language => 'اللغة';

  @override
  String get settings => 'إعدادات';

  @override
  String get light => 'نهاري';

  @override
  String get dark => 'ليلي';
}
