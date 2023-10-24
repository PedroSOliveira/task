import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget(
      {super.key, required this.categoryColor, required this.titleRadio});

  final Color categoryColor;
  final String titleRadio;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
              offset: const Offset(-22, 0),
              child: Text(
                titleRadio,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              )),
          value: 1,
          groupValue: 0,
          onChanged: (value) {
            print("Clicked");
          },
        ),
      ),
    );
  }
}
