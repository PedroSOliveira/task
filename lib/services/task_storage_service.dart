import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:task/models/task.dart';

class TaskStorageService {
  static const _key = 'app_task@tasks_v1';

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_key);
    if (tasksJson != null) {
      final List<dynamic> tasksList = json.decode(tasksJson);
      return tasksList.map((task) => Task.fromJson(task)).toList();
    }
    return [];
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_key, tasksJson);
  }

  static Future<void> addTask(Task newTask) async {
    final tasks = await getTasks();
    tasks.add(newTask);
    await saveTasks(tasks);
  }

  static Future<void> removeTask(String taskId) async {
    final tasks = await getTasks();
    final updatedTasks = tasks.where((task) => task.id != taskId).toList();
    await saveTasks(updatedTasks);
  }

  static Future<void> updateTask(Task updatedTask) async {
    final tasks = await getTasks();
    final updatedTasks = tasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    await saveTasks(updatedTasks);
  }

  static Future<Task?> getTaskById(String taskId) async {
    final tasks = await getTasks();
    for (var task in tasks) {
      if (task.id == taskId) {
        return task;
      }
    }
    return null;
  }
}
