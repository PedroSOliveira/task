import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/models/task.dart';

import 'package:task/screens/task/components/date_item.dart';
import 'package:task/screens/task/components/detail_item.dart';
import 'package:task/screens/task/components/notes_item.dart';

class TaskDetailsPage extends StatefulWidget {
  TaskDetailsPage({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // String formattedDate = DateFormat('dd/MM/yyyy').format(widget.task.date);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 245, 249),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 245, 249),
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Para estender os filhos na horizontal
            children: [
              const SizedBox(height: 10),
              TaskTitleColumn(title: widget.task.title),
              const SizedBox(height: 10),
              TaskDateTimeColumn(date: "", time: '10:00'),
              const SizedBox(height: 10),
              const TaskNotesColumn(
                notes:
                    'Esta é uma descrição da tarefa. Aqui você pode adicionar notas e detalhes adicionais sobre a tarefa.',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
