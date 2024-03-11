import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:task/components/show_model.dart';
import 'package:task/mocks/fakes_tasks.dart';
import 'package:task/screens/home/components/category_tile.dart';
import 'package:task/screens/task/task.dart';
import 'package:task/widget/card_todo_widget.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> categories = ['Trabalho', 'Entretenimento', 'Viagem', 'Pessoal'];

  String selectedCategory = 'Trabalho';

  void _selectedOptionCategory(String option) {
    setState(() {
      selectedCategory = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 245, 249),
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
                      color: Colors.white),
                  child: Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.blue, // Define a cor do texto e dos ícones
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
                              print(newDate.toString());
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
                // ListView.separated(
                //   itemCount: mockTasks.length,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) => CardTodo(
                //     task: mockTasks[index],
                //   ),
                //   separatorBuilder: (context, index) => const SizedBox(
                //     height: 10,
                //   ), // Espaço horizontal entre os itens
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
