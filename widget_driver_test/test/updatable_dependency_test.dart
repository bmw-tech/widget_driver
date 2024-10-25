import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

void main() {
  group('Updatable Dependency tests', () {
    testWidgets('should build with initial value', (WidgetTester tester) async {
      final valueNotifier = ValueNotifier<int>(0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpdatableDependency<int>(
              valueNotifier: valueNotifier,
              builder: (value) {
                return Text('Value: $value');
              },
            ),
          ),
        ),
      );

      expect(find.text('Value: 0'), findsOneWidget);
    });

    testWidgets('should update on value change', (WidgetTester tester) async {
      final valueNotifier = ValueNotifier<int>(0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpdatableDependency<int>(
              valueNotifier: valueNotifier,
              builder: (value) {
                return Text('Value: $value');
              },
            ),
          ),
        ),
      );

      valueNotifier.value = 123;
      await tester.pumpAndSettle();

      expect(find.text('Value: 123'), findsOneWidget);
    });

    testWidgets('should work with different types', (WidgetTester tester) async {
      final valueNotifier = ValueNotifier<String>('initial');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpdatableDependency<String>(
              valueNotifier: valueNotifier,
              builder: (value) {
                return Text('Value: $value');
              },
            ),
          ),
        ),
      );

      expect(find.text('Value: initial'), findsOneWidget);

      valueNotifier.value = 'updated';
      await tester.pumpAndSettle();

      expect(find.text('Value: updated'), findsOneWidget);
    });
  });
}
