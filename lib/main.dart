import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

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
      home: const TaskFlowHomePage(),
    );
  }
}

class TaskFlowHomePage extends StatefulWidget {
  const TaskFlowHomePage({super.key});

  @override
  State<TaskFlowHomePage> createState() => _TaskFlowHomePageState();
}

class _TaskFlowHomePageState extends State<TaskFlowHomePage> {
  final String studentName = 'Jandry Cedeño';
  final int dailyGoal = 5;
  int pendingTasks = 3;
  int completedTasks = 0;

  void _addTask() {
    setState(() {
      pendingTasks++;
    });
  }

  void _completeTask() {
    if (pendingTasks == 0) {
      return;
    }

    setState(() {
      pendingTasks--;
      if (completedTasks < dailyGoal) {
        completedTasks++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusMessage = pendingTasks == 0
        ? '¡Excelente! No tienes tareas pendientes.'
        : 'Aún tienes tareas por organizar.';

    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Hola, $studentName!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(statusMessage),
              const SizedBox(height: 28),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.pending_actions),
                      const SizedBox(width: 12),
                      Text('Tareas pendientes: $pendingTasks'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.task_alt),
                      const SizedBox(width: 12),
                      Text('Completadas hoy: $completedTasks de $dailyGoal'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addTask,
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar tarea'),
                  ),
                  OutlinedButton.icon(
                    onPressed: pendingTasks == 0 ? null : _completeTask,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Completar una tarea'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
