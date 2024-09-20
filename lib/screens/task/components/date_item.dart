import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart' as cdp;
import 'package:task/models/task.dart';
import 'package:task/services/task_service.dart';
import 'package:task/theme/manager_theme.dart';

class TaskDateTimeColumn extends StatefulWidget {
  final String date;
  final String time;
  final Task task;

  const TaskDateTimeColumn({
    Key? key,
    required this.date,
    required this.time,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskDateTimeColumn> createState() => _TaskDateTimeColumnState();
}

class _TaskDateTimeColumnState extends State<TaskDateTimeColumn> {
  String dateTask = '';
  String timeTask = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      dateTask = widget.date;
      timeTask = widget.time;
    });
  }

  // void _showDatePicker(BuildContext context) async {

  void _updateDateTask(String newDate) {
    final TaskService taskService = TaskService();
    final Timestamp combinedTimestamp =
        convertCombinatedDateAndTime(newDate, widget.time);

    try {
      setState(() {
        dateTask = newDate;
      });
      Task updatedTask = widget.task.copyWith(date: combinedTimestamp);
      taskService.updateTask(widget.task.id, updatedTask);
    } catch (e) {
      print('Erro ao atualizar task: $e');
    }
  }

  void _updateTimeTask(String newTime) {
    final TaskService taskService = TaskService();
    final Timestamp combinedTimestamp =
        convertCombinatedDateAndTime(dateTask, newTime);

    final convertTime =
        combinedTimestamp.toDate().add(const Duration(hours: -3));

    final Timestamp adjustedTimestamp = Timestamp.fromDate(convertTime);

    try {
      setState(() {
        timeTask = newTime;
      });
      Task updatedTask = widget.task.copyWith(date: adjustedTimestamp);
      taskService.updateTask(widget.task.id, updatedTask);
    } catch (e) {
      print('Erro ao atualizar task: $e');
    }
  }

  Timestamp convertDateToTimestamp(String date) {
    final formattedDate = DateFormat('dd/MM/yyyy').parse(date);

    return Timestamp.fromDate(formattedDate);
  }

  Timestamp convertTimeToTimestamp(String time) {
    final formattedTime = DateFormat('HH:mm').parse(time).toUtc();

    return Timestamp.fromDate(formattedTime);
  }

  Timestamp convertCombinatedDateAndTime(String newDate, String newTime) {
    final dateTimestamp = convertDateToTimestamp(newDate);
    final timeTimestamp = convertTimeToTimestamp(newTime);

    final combinedTimestamp = Timestamp(
      dateTimestamp.seconds + timeTimestamp.seconds,
      dateTimestamp.nanoseconds,
    );

    return combinedTimestamp;
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: const Color.fromARGB(255, 240, 245, 249),
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.blue, // Define a cor do texto e dos ícones
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateChanged: (DateTime newDate) {
                        Navigator.pop(context, newDate);
                      },
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (pickedDate != null) {
      _updateDateTask(DateFormat('dd/MM/yyyy').format(pickedDate));
    }
  }

  void _showTimePicker(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.white,
              inversePrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      _updateTimeTask(pickedTime.format(context));
    }
  }

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
          GestureDetector(
            onTap: () => _showDatePicker(context),
            child: Row(
              children: [
                Icon(
                  Icons.event,
                  color: iconColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Data',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  dateTask,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                  size: 15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showTimePicker(context),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: iconColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Hora',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  timeTask,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                  size: 15,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.notifications,
          //       color: Colors.grey,
          //       size: 20,
          //     ),
          //     const SizedBox(width: 10),
          //     const Text(
          //       'Lembrete',
          //       style: TextStyle(
          //         color: Colors.grey,
          //         fontSize: 14,
          //       ),
          //     ),
          //     const Spacer(),
          //     Text(
          //       widget.date,
          //       style: const TextStyle(
          //         fontSize: 14,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 5,
          //     ),
          //     const Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.grey,
          //       size: 15,
          //     ),
          //   ],
          // ),
          // // const SizedBox(height: 20),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.repeat,
          //       color: Colors.grey,
          //       size: 20,
          //     ),
          //     const SizedBox(width: 10),
          //     const Text(
          //       'Repetir',
          //       style: TextStyle(
          //         color: Colors.grey,
          //         fontSize: 14,
          //       ),
          //     ),
          //     const Spacer(),
          //     Text(
          //       widget.date,
          //       style: const TextStyle(
          //         fontSize: 14,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 5,
          //     ),
          //     const Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.grey,
          //       size: 15,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
