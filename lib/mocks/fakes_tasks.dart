import 'package:task/models/task.dart';

List<Task> mockTasks = [
  Task(
    id: 1,
    title: 'Estudar Flutter',
    date: DateTime.now(),
    status: 'Em progresso',
    category: 'Estudo',
  ),
  Task(
    id: 2,
    title: 'Fazer compras',
    date: DateTime.now().add(Duration(days: 1)),
    status: 'Pendente',
    category: 'Compras',
  ),
  Task(
    id: 3,
    title: 'Reunião com cliente',
    date: DateTime.now().add(Duration(days: 2)),
    status: 'Pendente',
    category: 'Trabalho',
  ),
  Task(
    id: 4,
    title: 'Correr no parque',
    date: DateTime.now().add(Duration(days: 3)),
    status: 'Concluído',
    category: 'Saúde',
  ),
  Task(
    id: 5,
    title: 'Limpar a casa',
    date: DateTime.now().add(Duration(days: 4)),
    status: 'Pendente',
    category: 'Casa',
  ),
];