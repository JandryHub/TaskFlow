import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('Task list renders scrollable task cards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.text('Revisar apuntes de Flutter'), findsOneWidget);
    expect(find.textContaining('Prioridad: Alta'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Revisar el código antes de entregar'),
      300,
    );
    expect(find.text('Revisar el código antes de entregar'), findsOneWidget);
  });
}
