import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  late String id;
  late String category;
  late Timestamp date;
  late String description;
  late bool isDone;
  late String title;
  late String user;
  late List<Map<String, dynamic>> notes;

  Task({
    required this.id,
    required this.category,
    required this.date,
    required this.description,
    required this.isDone,
    required this.title,
    required this.user,
    required this.notes,
  });

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Task(
      id: snapshot.id,
      category: data['category'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      description: data['description'] ?? '',
      isDone: data['isDone'] ?? false,
      title: data['title'] ?? '',
      user: data['user'] ?? '',
      notes: List<Map<String, dynamic>>.from(data['notes'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'date': date,
      'description': description,
      'isDone': isDone,
      'title': title,
      'user': user,
      'notes': notes,
    };
  }

  Task copyWith({
    String? id,
    String? category,
    Timestamp? date,
    String? description,
    bool? isDone,
    String? title,
    String? user,
    List<Map<String, dynamic>>? notes,
  }) {
    return Task(
      id: id ?? this.id,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
      user: user ?? this.user,
      notes: notes ?? this.notes,
    );
  }
}
