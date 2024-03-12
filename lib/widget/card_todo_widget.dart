import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/task/task.dart';

class CardTodo extends StatelessWidget {
  const CardTodo({Key? key, required this.task}) : super(key: key);

  final Task task;

  void _navigateToTaskDetailsScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskDetailsPage(
        task: task,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = task.date.toDate();

    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

    return GestureDetector(
      onTap: () {
        _navigateToTaskDetailsScreen(context);
      },
      child: Container(
        // height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title),
                  const Gap(5),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const Gap(5),
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale:
                  1.25, // Altere este valor para ajustar o tamanho do checkbox
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.light(
                    primary: Colors.grey.shade400, // Cor da borda
                  ),
                ),
                child: Checkbox(
                  activeColor: Colors.grey.shade400,
                  shape: CircleBorder(
                    side: BorderSide(
                        color: Colors.grey.shade400, width: 1), // Cor da borda
                  ),
                  value: false,
                  onChanged: (value) => print("object"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
