import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/base/base_screen.dart';
import 'package:task/services/task_service.dart';
import 'package:task/theme/manager_theme.dart';
import 'package:task/widget/card_todo_widget.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TaskService _taskService = TaskService();

  late List<Task> tasks = [];

  late List<Task> allTasks = [];

  final themeModeManager = ThemeModeManager();

  bool isLoading = false;

  void _selectedDateFilter(DateTime selectedDate) {
    List<Task> filteredTasks = allTasks.where((task) {
      DateTime taskDate = DateTime.parse(task.date);
      return taskDate.year == selectedDate.year &&
          taskDate.month == selectedDate.month &&
          taskDate.day == selectedDate.day;
    }).toList();

    setState(() {
      tasks = filteredTasks;
    });
  }

  List<Task> sortTasksByIsDone(List<Task> tasks) {
    tasks.sort((a, b) {
      if (a.isDone && !b.isDone) {
        return 1;
      } else if (!a.isDone && b.isDone) {
        return -1;
      } else {
        return 0;
      }
    });

    return tasks;
  }

  Future<List<Task>> filterTasksByToday(List<Task> tasks) async {
    DateTime today = DateTime.now();

    List<Task> filteredTasks = tasks.where((task) {
      DateTime taskDate = DateTime.parse(task.date);
      return taskDate.year == today.year &&
          taskDate.month == today.month &&
          taskDate.day == today.day;
    }).toList();

    return filteredTasks;
  }

  Future<void> _fetchTasks() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Task> fetchedTasks =
          await _taskService.getTasks(auth.currentUser!.email!);
      List<Task> sortedTasks = sortTasksByIsDone(fetchedTasks);
      List<Task> todayTasks = await filterTasksByToday(sortedTasks);

      setState(() {
        tasks = todayTasks;
        allTasks = sortedTasks;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Color get backgroundColor => ThemeModeManager.isDark
      ? Colors.grey.shade900
      : const Color.fromARGB(255, 240, 245, 249);

  Color get calendarColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.white;

  Color get iconNotFoundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade700 : Colors.blue.shade200;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // widget.getTasks();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BaseScreen(
                            themeModeManager: themeModeManager,
                          )));
            },
          ),
          backgroundColor: backgroundColor,
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: 378,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: calendarColor,
                    ),
                    child: Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary:
                              Colors.blue, // Define a cor do texto e dos ícones
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CalendarDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              onDateChanged: (DateTime newDate) {
                                _selectedDateFilter(newDate);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  tasks.isNotEmpty
                      ? ListView.separated(
                          itemCount: tasks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => CardTodo(
                            task: tasks[index],
                            getTasks: _fetchTasks,
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        )
                      : Column(
                          children: [
                            const Gap(50),
                            Icon(
                              Icons.announcement,
                              color: iconNotFoundColor,
                              size: 100,
                            ),
                            const Gap(10),
                            const Text(
                              'Sem atividades para este dia.',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
