import 'package:flutter/material.dart';
import 'package:task/theme/manager_theme.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.maxLine});

  final TextEditingController controller;
  final String hintText;
  final int maxLine;

  Color get contentBackgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: contentBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
        maxLines: maxLine,
      ),
    );
  }
}
