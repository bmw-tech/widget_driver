import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class MockWidgetDriver extends Mock implements WidgetDriver {}

void main() {
  group('WidgetTesterExtension:', () {
    testWidgets('Should return DriverTester', (WidgetTester tester) async {
      final driverTester = await tester.getDriverTester<MockWidgetDriver>(
        driverBuilder: () => MockWidgetDriver(),
      );

      expect(driverTester, isNotNull);
      expect(driverTester.driver, isA<MockWidgetDriver>());
    });

    testWidgets('Should work with parentWidgetBuilder', (WidgetTester tester) async {
      final driverTester = await tester.getDriverTester<MockWidgetDriver>(
        driverBuilder: () => MockWidgetDriver(),
        parentWidgetBuilder: (driverWidget) {
          return MaterialApp(
            home: Scaffold(body: driverWidget),
          );
        },
      );

      expect(driverTester, isNotNull);
      expect(driverTester.driver, isA<MockWidgetDriver>());
    });
  });
}
