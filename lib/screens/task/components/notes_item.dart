import 'package:flutter/material.dart';
import 'package:task/theme/manager_theme.dart';

class TaskNotesColumn extends StatelessWidget {
  final String notes;

  const TaskNotesColumn({Key? key, required this.notes}) : super(key: key);

  Color get contentBackgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.white;

  Color get textColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.grey;

  Color get iconColor =>
      ThemeModeManager.isDark ? Colors.grey.shade600 : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: contentBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notes,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Notas',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            notes,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
