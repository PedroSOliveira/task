import 'package:flutter/material.dart';

class DatePickerModal extends StatefulWidget {
  const DatePickerModal({Key? key}) : super(key: key);

  @override
  _DatePickerModalState createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: (DateTime newDate) {
              Navigator.pop(context, newDate);
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedDate);
            },
            child: Text('Selecionar'),
          ),
        ],
      ),
    );
  }
}
