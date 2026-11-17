// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('Welcome screen shows TaskFlow information', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('TaskFlow'), findsOneWidget);
    expect(find.text('¡Hola, Jandry Cedeño!'), findsOneWidget);
    expect(find.text('Tareas pendientes: 3'), findsOneWidget);
    expect(
      find.text('Un paso a la vez: cada tarea completada te acerca a tu meta.'),
      findsOneWidget,
    );
  });
}
