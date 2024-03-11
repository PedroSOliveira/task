import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/home/components/category_tile.dart';
import 'package:task/screens/login/login_screen.dart';
import 'package:task/services/task_service.dart';
import 'package:task/widget/card_todo_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ['Trabalho', 'Entretenimento', 'Viagem', 'Pessoal'];

  String selectedCategory = 'Trabalho';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TaskService _taskService = TaskService();

  late List<Task> tasks = [];

  void _selectedOptionCategory(String option) {
    setState(() {
      selectedCategory = option;
    });
  }

  void _handleSignOut() async {
    await _auth.signOut();
    final pageRoute = MaterialPageRoute(builder: (context) => LoginScreen());

    Navigator.of(context).pushReplacement(pageRoute);
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      List<Task> fetchedTasks = await _taskService.getTasks();
      setState(() {
        tasks = fetchedTasks;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 245, 247),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          _handleSignOut();
          // final pageRoute =
          //     MaterialPageRoute(builder: (context) => LoginScreen());

          // Navigator.of(context).pushReplacement(pageRoute);
        },
        // showModalBottomSheet(
        //   isScrollControlled: true,
        //   context: context,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        //   builder: (context) => AddNewTaskModel(),
        // ),
        elevation: 1,
        backgroundColor: Colors.blue.shade500, // Ícone
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
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
                    CupertinoIcons.calendar,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bell,
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
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return CategoryTile(
                      category: categories[index],
                      isSelected: categories[index] == selectedCategory,
                      onPressed: () =>
                          _selectedOptionCategory(categories[index]),
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(
                    width: 15,
                  ),
                  itemCount: categories.length,
                ),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                itemCount: tasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => CardTodo(task: tasks[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
