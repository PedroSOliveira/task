import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:task/components/show_model.dart';
import 'package:task/widget/card_todo_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            // child: Image.asset("name"),
          ),
          title: Text(
            "Olá, usuário",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: const Text(
            "Pedro Oliveira",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's tasks",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Wednesday, 11 May",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD5E8FA),
                        foregroundColor: Colors.blue.shade700,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      builder: (context) => AddNewTaskModel(),
                    ),
                    child: const Text(
                      '+ New Task',
                    ),
                  ),
                ],
              ),
              const Gap(20),
              ListView.separated(
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) => const CardTodo(),
                separatorBuilder: (context, index) =>
                    SizedBox(height: 10), // Espaço horizontal entre os itens
              ),
            ],
          ),
        ),
      ),
    );
  }
}
