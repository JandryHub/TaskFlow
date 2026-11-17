import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'task.dart';

void main() {
  runApp(const TaskFlowApp());
}

const demoTasks = <Task>[
  Task(
    id: 1,
    title: 'Revisar apuntes de Flutter',
    description: 'Repasar widgets y estado para la siguiente práctica.',
    priority: 'Alta',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 2,
    title: 'Preparar exposición',
    description: 'Organizar diapositivas y practicar la presentación.',
    priority: 'Alta',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 3,
    title: 'Organizar entregas de la semana',
    description: 'Anotar fechas y ordenar actividades por prioridad.',
    priority: 'Media',
    isCompleted: true,
    userId: 1,
  ),
  Task(
    id: 4,
    title: 'Completar práctica de interfaces',
    description: 'Terminar los componentes solicitados en clase.',
    priority: 'Media',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 5,
    title: 'Revisar el código antes de entregar',
    description: 'Ejecutar el análisis y corregir advertencias.',
    priority: 'Baja',
    isCompleted: false,
    userId: 1,
  ),
];

Task? findTask(int? id) {
  if (id == null) {
    return null;
  }

  for (final task in demoTasks) {
    if (task.id == id) {
      return task;
    }
  }
  return null;
}

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TaskListScreen()),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.tryParse(state.pathParameters['id'] ?? '');
        return TaskDetailScreen(task: findTask(taskId));
      },
    ),
  ],
);

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: task.isCompleted ? Colors.green.shade50 : null,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text('${task.id}')),
        title: Text(task.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    label: Text(task.priority),
                    backgroundColor: _priorityColor(task.priority),
                    side: BorderSide.none,
                  ),
                  Chip(
                    label: Text(task.isCompleted ? 'Completada' : 'Pendiente'),
                    backgroundColor: task.isCompleted
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    side: BorderSide.none,
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'alta':
        return Colors.red.shade100;
      case 'media':
        return Colors.orange.shade100;
      case 'baja':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
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
          final task = demoTasks[index];
          return TaskCard(
            task: task,
            onTap: () => context.push('/task/${task.id}'),
          );
        },
      ),
    );
  }
}

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    final selectedTask = task;
    if (selectedTask == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle de tarea')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off, size: 48),
                const SizedBox(height: 12),
                const Text('No se encontró la tarea.'),
                const SizedBox(height: 16),
                FilledButton.tonalIcon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver al listado'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de tarea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tarea #${selectedTask.id}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Text(
              selectedTask.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(selectedTask.description),
            const SizedBox(height: 16),
            Chip(label: Text('Prioridad: ${selectedTask.priority}')),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                selectedTask.isCompleted
                    ? 'Estado: completada'
                    : 'Estado: pendiente',
              ),
            ),
            const SizedBox(height: 8),
            Text('Usuario: ${selectedTask.userId}'),
            const SizedBox(height: 32),
            FilledButton.tonalIcon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al listado'),
            ),
          ],
        ),
      ),
    );
  }
}
