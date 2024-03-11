import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Task>> getTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('todo').get();
      List<Task> tasks = querySnapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList();
      return tasks;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }
}