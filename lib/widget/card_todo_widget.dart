import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.grey,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.grey;
                              }
                              return Colors.grey.shade300;
                            }),
                            shape: const CircleBorder(
                              side: BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            value: false,
                            onChanged: (value) => print("object"),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 18,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '10/03/2024 - 11:45',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
