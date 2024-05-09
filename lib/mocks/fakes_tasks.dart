import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/task.dart';

List<Task> mockTasks = [
  Task(
      id: '1',
      title: 'Estudar Flutter',
      date: Timestamp.now(),
      category: 'Estudo',
      isDone: false,
      user: '',
      description: 'Estudar',
      notes: [],
      ),
  Task(
      id: '2',
      title: 'Fazer compras',
      date: Timestamp.now(),
      category: 'Compras',
      isDone: false,
      user: '',
      description: 'Estudar',
      notes: [],
      ),
  Task(
      id: '3',
      title: 'Reunião com cliente',
      date: Timestamp.now(),
      category: 'Trabalho',
      isDone: false,
      user: '',
      description: 'Estudar',
      notes: [],
      ),
  Task(
    id: '4',
    title: 'Correr no parque',
      date: Timestamp.now(),
    category: 'Saúde',
    isDone: false,
    user: '',
    description: 'Estudar',
    notes: [],
  ),
  Task(
      id: '5',
      title: 'Limpar a casa',
      date: Timestamp.now(),
      category: 'Casa',
      isDone: false,
      user: '',
      description: 'Estudar',
      notes: []),
];
