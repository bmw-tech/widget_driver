import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver/widget_driver.dart';
import 'test_helpers/test_container_drivable_widget.dart';

class _MockRuntimeEnvironmentInfo extends Mock
    implements RuntimeEnvironmentInfo {}

void main() {
  group('DrivableWidget:', () {
    late _MockRuntimeEnvironmentInfo _mockRuntimeEnvironmentInfo;

    setUp(() {
      _mockRuntimeEnvironmentInfo = _MockRuntimeEnvironmentInfo();
    });

    testWidgets('Uses real driver when not in test environment',
        (WidgetTester tester) async {
      when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment())
          .thenReturn(false);

      final testContainerDrivableWidget = TestContainerDrivableWidget(
        environmentInfo: _mockRuntimeEnvironmentInfo,
      );
      await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

      final driver = testContainerDrivableWidget.driver;
      expect(driver.runtimeType, TestContainerDriver);
    });

    testWidgets('Uses test driver when in test environment',
        (WidgetTester tester) async {
      when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment())
          .thenReturn(true);

      final testContainerDrivableWidget = TestContainerDrivableWidget(
        environmentInfo: _mockRuntimeEnvironmentInfo,
      );
      await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

      final driver = testContainerDrivableWidget.driver;
      expect(driver.runtimeType, TestContainerTestDriver);
    });

    testWidgets('Can access its driver', (WidgetTester tester) async {
      when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment())
          .thenReturn(false);

      final testContainerDrivableWidget = TestContainerDrivableWidget(
        environmentInfo: _mockRuntimeEnvironmentInfo,
      );
      await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

      final driver = testContainerDrivableWidget.driver;
      expect(driver.aTestText, 'A test text');
    });

    testWidgets(
        'Calling `aTestMethod` on driver makes widget reload with new data',
        (WidgetTester tester) async {
      when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment())
          .thenReturn(false);

      final testContainerDrivableWidget = TestContainerDrivableWidget(
        environmentInfo: _mockRuntimeEnvironmentInfo,
      );
      await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));
      final driver = testContainerDrivableWidget.driver;

      expect(find.text('didCallTestMethod: false'), findsOneWidget);

      driver.aTestMethod();
      await tester.pump();

      expect(find.text('didCallTestMethod: true'), findsOneWidget);
    });
  });
}
