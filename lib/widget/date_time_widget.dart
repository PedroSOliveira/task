import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task/constants/app_style.dart';
import 'package:task/theme/manager_theme.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.icon,
    required this.titleText,
    required this.valueText,
    required this.onTap,
  });

  final IconData icon;
  final String titleText;
  final String valueText;
  final VoidCallback onTap;

  Color get contentBackgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.grey.shade200;

  Color get textColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.grey.shade800;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                  color: contentBackgroundColor,
                  borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => onTap(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: contentBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: textColor,
                      ),
                      const Gap(6),
                      Text(
                        valueText,
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
