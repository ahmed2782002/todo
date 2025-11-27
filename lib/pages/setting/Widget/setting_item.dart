import 'package:flutter/material.dart';

typedef SettingsOptionClicked = void Function();

class SettingItem extends StatelessWidget {
  final String settingOptionText, selectedOption;
  final SettingsOptionClicked onOptionTapped;

  const SettingItem(
      {super.key,
      required this.settingOptionText,
      required this.selectedOption,
      required this.onOptionTapped});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          settingOptionText,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: theme.colorScheme.onSecondary,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onOptionTapped,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: mediaQuery.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: theme.primaryColor,
                  width: 1.2,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOption,
                  style: theme.textTheme.titleLarge!
                      .copyWith(fontSize: 14, color: theme.primaryColor),
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
