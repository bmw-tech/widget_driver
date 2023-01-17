import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver/widget_driver.dart';

class _MockTestContainerDriver extends Mock implements _TestContainerDriver {}

void main() {
  group('MockDriverProvider:', () {
    late _MockTestContainerDriver _mockTestContainerDriver;

    setUp(() {
      _mockTestContainerDriver = _MockTestContainerDriver();
    });

    testWidgets('Verify that mocked driver overrides real driver property',
        (WidgetTester tester) async {
      when(() => _mockTestContainerDriver.aTestText).thenReturn("A mock text");

      final testContainerWidget = _TestContainerDrivableWidget();
      final mockDriverProvider = MockDriverProvider<_TestContainerDriver>(
        value: _mockTestContainerDriver,
        child: testContainerWidget,
      );

      await tester.pumpWidget(MaterialApp(home: mockDriverProvider));

      expect(find.text('A mock text'), findsOneWidget);
    });

    testWidgets('Should not notify child widgets when driver is the same',
        (WidgetTester tester) async {
      final mockedDriver = _MockTestContainerDriver();

      final testContainerWidget = _TestContainerDrivableWidget();
      final mockDriverProviderInitial =
          MockDriverProvider<_TestContainerDriver>(
        value: mockedDriver,
        child: testContainerWidget,
      );
      final mockDriverProviderUpdated =
          MockDriverProvider<_TestContainerDriver>(
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

      final testContainerWidget = _TestContainerDrivableWidget();
      final mockDriverProviderInitial =
          MockDriverProvider<_TestContainerDriver>(
        value: mockedDriverInitial,
        child: testContainerWidget,
      );
      final mockDriverProviderUpdated =
          MockDriverProvider<_TestContainerDriver>(
        value: mockedDriverUpdated,
        child: testContainerWidget,
      );

      final shouldNotify = mockDriverProviderUpdated
          .updateShouldNotify(mockDriverProviderInitial);

      expect(shouldNotify, true);
    });
  });
}

class _TestContainerDriver extends WidgetDriver {
  _TestContainerDriver(BuildContext context) : super(context);

  String get aTestText => 'A test text';
}

class _TestContainerDriverProvider
    extends WidgetDriverProvider<_TestContainerDriver> {
  @override
  _TestContainerDriver buildDriver(BuildContext context) {
    return _TestContainerDriver(context);
  }

  @override
  _TestContainerDriver buildTestDriver() {
    throw UnimplementedError();
  }
}

class _TestContainerDrivableWidget
    extends DrivableWidget<_TestContainerDriver> {
  @override
  Widget build(BuildContext context) {
    return Text(driver.aTestText);
  }

  @override
  WidgetDriverProvider<_TestContainerDriver> get driverProvider =>
      _TestContainerDriverProvider();
}
