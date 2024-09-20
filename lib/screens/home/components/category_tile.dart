import 'package:flutter/material.dart';
import 'package:task/config/custom_colors.dart';
import 'package:task/theme/manager_theme.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onPressed});

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  Color get isDesativeColor => ThemeModeManager.isDark
      ? Colors.grey.shade800
      : const Color.fromARGB(255, 230, 232, 233);

  Color? get isActiveColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.blue[100];

  Color get isDesativeTextColor => ThemeModeManager.isDark
      ? const Color.fromARGB(255, 230, 232, 233)
      : Colors.grey.shade800;

  Color? get isActiveTextColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.blue[400];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? isActiveColor : isDesativeColor),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? isActiveTextColor : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
