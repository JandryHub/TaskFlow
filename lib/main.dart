import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
}

const demoTasks = [
  Task(
    id: 1,
    title: 'Revisar apuntes de Flutter',
    description: 'Repasar widgets y estado para la siguiente práctica.',
    priority: 'Alta',
    isCompleted: false,
  ),
  Task(
    id: 2,
    title: 'Preparar exposición',
    description: 'Organizar diapositivas y practicar la presentación.',
    priority: 'Alta',
    isCompleted: false,
  ),
  Task(
    id: 3,
    title: 'Organizar entregas de la semana',
    description: 'Anotar fechas y ordenar actividades por prioridad.',
    priority: 'Media',
    isCompleted: true,
  ),
  Task(
    id: 4,
    title: 'Completar práctica de interfaces',
    description: 'Terminar los componentes solicitados en clase.',
    priority: 'Media',
    isCompleted: false,
  ),
  Task(
    id: 5,
    title: 'Revisar el código antes de entregar',
    description: 'Ejecutar el análisis y corregir advertencias.',
    priority: 'Baja',
    isCompleted: false,
  ),
];

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : null,
        ),
        title: Text(task.title),
        subtitle: Text('${task.description}\nPrioridad: ${task.priority}'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas'), centerTitle: false),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: demoTasks[index]);
        },
      ),
    );
  }
}
