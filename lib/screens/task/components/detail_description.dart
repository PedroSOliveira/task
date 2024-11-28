import 'package:flutter/material.dart';
import 'package:task/models/task.dart';
import 'package:task/services/task_service.dart';
import 'package:task/services/task_storage_service.dart';
import 'package:task/theme/manager_theme.dart';

class TaskDescriptionColumn extends StatefulWidget {
  final Task task;

  TaskDescriptionColumn({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDescriptionColumn> createState() => _TaskDescriptionColumnState();
}

class _TaskDescriptionColumnState extends State<TaskDescriptionColumn> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.task.description;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _controller != widget.task.description) {
        _updateDescriptionTask();
      }
    });
  }

  void _updateDescriptionTask() {
    try {
      Task updatedTask = widget.task.copyWith(description: _controller.text);
      TaskStorageService.updateTask(updatedTask);
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

  Color get textColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.black;

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
                'Descrição',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 280,
                child: TextFormField(
                  maxLines: 5,
                  controller: _controller,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: textColor,
                  ),
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
