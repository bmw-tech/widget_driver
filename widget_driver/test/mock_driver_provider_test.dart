import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver/widget_driver.dart';

import 'test_helpers/test_container_drivable_widget.dart';

class _MockTestContainerDriver extends Mock implements TestContainerDriver {}

void main() {
  group('MockDriverProvider:', () {
    late _MockTestContainerDriver _mockTestContainerDriver;

    setUp(() {
      _mockTestContainerDriver = _MockTestContainerDriver();
      when(() => _mockTestContainerDriver.didCallTestMethod).thenReturn(false);
    });

    testWidgets('Verify that mocked driver overrides real driver property',
        (WidgetTester tester) async {
      when(() => _mockTestContainerDriver.aTestText).thenReturn("A mock text");

      final testContainerWidget = TestContainerDrivableWidget();
      final mockDriverProvider = MockDriverProvider<TestContainerDriver>(
        value: _mockTestContainerDriver,
        child: testContainerWidget,
      );

      await tester.pumpWidget(MaterialApp(home: mockDriverProvider));

      expect(find.text('A mock text'), findsOneWidget);
    });

    testWidgets('Should not notify child widgets when driver is the same',
        (WidgetTester tester) async {
      final mockedDriver = _MockTestContainerDriver();

      final testContainerWidget = TestContainerDrivableWidget();
      final mockDriverProviderInitial = MockDriverProvider<TestContainerDriver>(
        value: mockedDriver,
        child: testContainerWidget,
      );
      final mockDriverProviderUpdated = MockDriverProvider<TestContainerDriver>(
        value: mockedDriver,
        child: testContainerWidget,
      );

      final shouldNotify = mockDriverProviderUpdated
          .updateShouldNotify(mockDriverProviderInitial);

      expect(shouldNotify, false);
    });

    testWidgets('Should notify child widgets when driver changed',
        (WidgetTester tester) async {
      final mockedDriverInitial = _MockTestContainerDriver();
      final mockedDriverUpdated = _MockTestContainerDriver();

      final testContainerWidget = TestContainerDrivableWidget();
      final mockDriverProviderInitial = MockDriverProvider<TestContainerDriver>(
        value: mockedDriverInitial,
        child: testContainerWidget,
      );
      final mockDriverProviderUpdated = MockDriverProvider<TestContainerDriver>(
        value: mockedDriverUpdated,
        child: testContainerWidget,
      );

      final shouldNotify = mockDriverProviderUpdated
          .updateShouldNotify(mockDriverProviderInitial);

      expect(shouldNotify, true);
    });
  });
}
