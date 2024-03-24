import 'package:flutter/material.dart';

class TaskNotesColumn extends StatelessWidget {
  final String notes;

  const TaskNotesColumn({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.notes,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Notas',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            notes,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
