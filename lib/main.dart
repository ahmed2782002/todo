import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/core/provider/list_provider.dart';
import 'package:to_do/pages/edit_task/edite_task.dart';
import 'package:to_do/splash_screen.dart';

import 'core/provider/prefs_helper.dart';
import 'core/theme/application_theme.dart';
import 'home/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init SharedPreferences
  PrefsHelper.prefs = await SharedPreferences.getInstance();

  // Init Firebase
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ListProvider()..init(),
      child: const MyApp(),
    ),
  );
}
// this is dev
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ListProvider appProvider = Provider.of<ListProvider>(context);
    return MaterialApp(
      theme: ApplicationTheme.lightTheme,
      darkTheme: ApplicationTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: appProvider.currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appProvider.currentLocale),
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SplashScreen.routeName: (_) => SplashScreen(),
        EditTask.routeName: (context) => EditTask(),
      },
    );
  }
}
