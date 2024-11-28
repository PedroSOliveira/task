import 'dart:convert';

class Task {
  late String id;
  late String category;
  late DateTime date;
  late String description;
  late bool isDone;
  late String title;
  late String user;
  late List<Map<String, dynamic>> notes;
  late bool isNotify;

  Task({
    required this.id,
    required this.category,
    required this.date,
    required this.description,
    required this.isDone,
    required this.title,
    required this.user,
    required this.notes,
    this.isNotify = false,
  });

  Task copyWith({
    String? id,
    String? category,
    DateTime? date,
    String? description,
    bool? isDone,
    String? title,
    String? user,
    List<Map<String, dynamic>>? notes,
    bool? isNotify,
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
      isNotify: isNotify ?? this.isNotify,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'date': date.toIso8601String(),
      'description': description,
      'isDone': isDone,
      'title': title,
      'user': user,
      'notes': jsonEncode(notes),
      'isNotify': isNotify,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      isDone: json['isDone'],
      title: json['title'],
      user: json['user'],
      notes: List<Map<String, dynamic>>.from(jsonDecode(json['notes'] ?? '[]')),
      isNotify: json['isNotify'] ?? false,
    );
  }
}
