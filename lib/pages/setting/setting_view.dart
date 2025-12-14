import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/provider/list_provider.dart';
import 'package:to_do/pages/setting/Widget/setting_item.dart';

import '../../l10n/app_localizations.dart';
import 'Widget/language_bottom_sheet.dart';
import 'Widget/theme_bottom_sheet.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ListProvider>(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(
                  AppLocalizations.of(context)!.settings,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
                flexibleSpace: SizedBox(
                  height: 0.20.sh, // بدل mediaQuery.height * .2
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 50.h,
          ),
          child: Column(
            children: [
              SettingItem(
                settingOptionText: AppLocalizations.of(context)!.language,
                selectedOption:
                appProvider.currentLocale == "en" ? "English" : "العربيه",
                onOptionTapped: () {
                  showLanguagesBottomSheet(context);
                },
              ),

              SizedBox(height: 40.h),

              SettingItem(
                settingOptionText: AppLocalizations.of(context)!.theme_Mode,
                selectedOption: appProvider.isDarkEnabled()
                    ? AppLocalizations.of(context)!.dark
                    : AppLocalizations.of(context)!.light,
                onOptionTapped: () {
                  showModeBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showLanguagesBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottom(),
    );
  }

  void showModeBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
    );
  }
}
