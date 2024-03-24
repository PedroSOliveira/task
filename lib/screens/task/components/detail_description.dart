import 'package:flutter/material.dart';
import 'package:task/models/task.dart';
import 'package:task/services/task_service.dart';

class TaskDescriptionColumn extends StatefulWidget {
  final Task task;

  TaskDescriptionColumn({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDescriptionColumn> createState() => _TaskDescriptionColumnState();
}

class _TaskDescriptionColumnState extends State<TaskDescriptionColumn> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.task.description;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _updateDescriptionTask();
        print('Teclado foi fechado');
      }
    });
  }

  void _updateDescriptionTask() {
    try {
      Task updatedTask = widget.task.copyWith(description: _controller.text);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                width: 280,
                child: TextFormField(
                  maxLines: 5,
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
