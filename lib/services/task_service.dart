import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Task>> getTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('todo').get();
      List<Task> tasks =
          querySnapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList();
      return tasks;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _firestore.collection('todo').add(task.toMap());
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('todo').doc(taskId).update(newData);
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('todo').doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
