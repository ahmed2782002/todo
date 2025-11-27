import 'package:flutter/material.dart';

class UnSelectedOption extends StatelessWidget {
  final String titleUnselectedOption;

  const UnSelectedOption({super.key, required this.titleUnselectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Text(titleUnselectedOption),
    );
  }
}
