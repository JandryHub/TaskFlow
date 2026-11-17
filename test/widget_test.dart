import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';
import 'package:taskflow/task.dart';

void main() {
  test('Task.fromJson maps all session 5 fields', () {
    final task = Task.fromJson({
      'id': 7,
      'title': 'Preparar exposición',
      'description': 'Organizar diapositivas y practicar',
      'priority': 'Alta',
      'isCompleted': false,
      'userId': 1,
    });

    expect(task.id, 7);
    expect(task.title, 'Preparar exposición');
    expect(task.description, 'Organizar diapositivas y practicar');
    expect(task.priority, 'Alta');
    expect(task.isCompleted, isFalse);
    expect(task.userId, 1);
  });

  testWidgets('List and detail show the selected task data', (
    WidgetTester tester,
  ) async {
    expect(demoTasks.map((task) => task.id).toSet(), hasLength(5));

    await tester.pumpWidget(const TaskFlowApp());
    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.text('Revisar apuntes de Flutter'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Organizar entregas de la semana'),
      300,
    );
    await tester.tap(find.text('Organizar entregas de la semana'));
    await tester.pumpAndSettle();

    expect(find.text('Tarea #3'), findsOneWidget);
    expect(
      find.text('Anotar fechas y ordenar actividades por prioridad.'),
      findsOneWidget,
    );
    expect(find.text('Prioridad: Media'), findsOneWidget);
    expect(find.text('Estado: completada'), findsOneWidget);
    expect(find.text('Usuario: 1'), findsOneWidget);

    await tester.tap(find.text('Volver al listado'));
    await tester.pumpAndSettle();
    expect(find.text('Mis tareas'), findsOneWidget);

    appRouter.go('/task/999');
    await tester.pumpAndSettle();
    expect(find.text('No se encontró la tarea.'), findsOneWidget);
  });
}
