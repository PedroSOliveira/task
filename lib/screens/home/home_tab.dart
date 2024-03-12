import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task/components/show_model.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/home/components/category_tile.dart';
import 'package:task/screens/login/login_screen.dart';
import 'package:task/screens/menuScreen/menu_tiles_screen.dart';
import 'package:task/services/task_service.dart';
import 'package:task/theme/manager_theme.dart';
import 'package:task/widget/card_todo_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    'Todas',
    'Trabalho',
    'Entretenimento',
    'Estudo',
    'Viagem',
    'Pessoal'
  ];

  String selectedCategory = 'Todas';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TaskService _taskService = TaskService();

  late List<Task> tasks = [];

  late List<Task> allTasks = [];

  final themeModeManager = ThemeModeManager();

  final String allCategories = 'Todas';

  void _selectedOptionCategory(String option) {
    setState(() {
      selectedCategory = option;
    });

    _filterTasksByCategory(option);
  }

  void _filterTasksByCategory(String category) {
    if (category == allCategories) {
      setState(() {
        tasks = allTasks;
      });
    } else {
      List<Task> filteredTasks =
          allTasks.where((task) => task.category == category).toList();

      setState(() {
        tasks = filteredTasks;
      });
    }
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
        allTasks = fetchedTasks;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  void toggleTheme() {
    setState(() {
      themeModeManager.themeMode = themeModeManager.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 245, 247),
      // backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            builder: (context) => const AddNewTaskModel(),
          );
        },
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
        iconTheme: const IconThemeData(color: Colors.blue),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    themeModeManager.themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.grey,
                  ),
                  onPressed: toggleTheme,
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
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          },
        ),
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
              tasks.isNotEmpty
                  ? ListView.separated(
                      itemCount: tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          CardTodo(task: tasks[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    )
                  : Column(
                      children: [
                        // Image.asset('assets/image-login.jpeg'),
                        const Gap(50),

                        Icon(
                          // Icons.not_listed_location_sharp,
                          Icons.announcement,
                          color: Colors.blue.shade200,
                          size: 180,
                        ),
                        const Gap(10),
                        const Text(
                          'Sem atividades dessa categoria.',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
