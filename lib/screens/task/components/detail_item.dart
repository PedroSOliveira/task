import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/models/task.dart';
import 'package:task/services/task_service.dart';
import 'package:task/theme/manager_theme.dart';

class TaskTitleColumn extends StatefulWidget {
  final Task task;

  TaskTitleColumn({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskTitleColumn> createState() => _TaskTitleColumnState();
}

class _TaskTitleColumnState extends State<TaskTitleColumn> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.task.title;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _updateTitleTask();
        print('Teclado foi fechado');
      }
    });
  }

  void _updateTitleTask() {
    try {
      Task updatedTask = widget.task.copyWith(title: _controller.text);
      taskService.updateTask(widget.task.id, updatedTask);
    } catch (e) {
      print('Erro ao atualizar task: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Color get contentBackgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: contentBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Título',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
