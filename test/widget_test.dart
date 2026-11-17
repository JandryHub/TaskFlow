// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('Task counts change and stay within their bounds', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Tareas pendientes: 3'), findsOneWidget);
    expect(find.text('Completadas hoy: 0 de 5'), findsOneWidget);

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Completar una tarea'));
      await tester.pump();
    }

    expect(find.text('Tareas pendientes: 0'), findsOneWidget);
    expect(find.text('Completadas hoy: 3 de 5'), findsOneWidget);
    expect(
      find.text('¡Excelente! No tienes tareas pendientes.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<OutlinedButton>(
            find.widgetWithText(OutlinedButton, 'Completar una tarea'),
          )
          .onPressed,
      isNull,
    );

    await tester.tap(find.text('Agregar tarea'));
    await tester.pump();
    expect(find.text('Tareas pendientes: 1'), findsOneWidget);

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Completar una tarea'));
      await tester.pump();
      await tester.tap(find.text('Agregar tarea'));
      await tester.pump();
    }

    await tester.tap(find.text('Completar una tarea'));
    await tester.pump();
    expect(find.text('Completadas hoy: 5 de 5'), findsOneWidget);
  });
}
