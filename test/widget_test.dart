import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('A task opens its detail and returns to the list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    await tester.tap(find.text('Revisar apuntes de Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle de tarea'), findsOneWidget);
    expect(
      find.text('Repasar widgets y estado para la siguiente práctica.'),
      findsOneWidget,
    );
    expect(find.text('Prioridad: Alta'), findsOneWidget);
    expect(find.text('Estado: pendiente'), findsOneWidget);

    await tester.tap(find.text('Volver al listado'));
    await tester.pumpAndSettle();

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.text('Revisar apuntes de Flutter'), findsOneWidget);
  });
}
