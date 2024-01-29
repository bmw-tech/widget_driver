import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver/widget_driver.dart';
import 'test_helpers/test_container_drivable_widget.dart';

class _MockRuntimeEnvironmentInfo extends Mock implements RuntimeEnvironmentInfo {}

void main() {
  group('DrivableWidget:', () {
    late _MockRuntimeEnvironmentInfo _mockRuntimeEnvironmentInfo;

    setUp(() {
      _mockRuntimeEnvironmentInfo = _MockRuntimeEnvironmentInfo();
    });

    Future<void> _tapButtonToIncreaseSomeData(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('increase_someData_button')));
      await tester.pumpAndSettle();
    }

    Future<void> _tapButtonWhichDoesNothingJustCallsSetState(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('just_calls_set_state_button')));
      await tester.pumpAndSettle();
    }

    group('Real & Test Drivers:', () {
      group('Not in test environment:', () {
        setUp(() {
          when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
        });

        testWidgets('Uses real driver when no test config', (WidgetTester tester) async {
          final testContainerDrivableWidget = TestContainerDrivableWidget(
            environmentInfo: _mockRuntimeEnvironmentInfo,
          );
          await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

          final driver = testContainerDrivableWidget.driver;
          expect(driver.runtimeType, TestContainerDriver);
        });

        testWidgets('Uses real driver when test config', (WidgetTester tester) async {
          final testContainerDrivableWidget = TestContainerDrivableWidget(
            environmentInfo: _mockRuntimeEnvironmentInfo,
          );
          final testConfigWidget = WidgetDriverTestConfigProvider(
            config: AlwaysUseTestDriverTestConfig(),
            child: testContainerDrivableWidget,
          );
          await tester.pumpWidget(MaterialApp(home: testConfigWidget));

          final driver = testContainerDrivableWidget.driver;
          expect(driver.runtimeType, TestContainerDriver);
        });
      });

      group('In test environment:', () {
        setUp(() {
          when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(true);
        });

        testWidgets('Uses test driver when no test config', (WidgetTester tester) async {
          final testContainerDrivableWidget = TestContainerDrivableWidget(
            environmentInfo: _mockRuntimeEnvironmentInfo,
          );
          await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

          final driver = testContainerDrivableWidget.driver;
          expect(driver.runtimeType, TestContainerTestDriver);
        });

        testWidgets('Uses test driver when test config allows test driver', (WidgetTester tester) async {
          final testContainerDrivableWidget = TestContainerDrivableWidget(
            environmentInfo: _mockRuntimeEnvironmentInfo,
          );
          final testConfigWidget = WidgetDriverTestConfigProvider(
            config: AlwaysUseTestDriverTestConfig(),
            child: testContainerDrivableWidget,
          );
          await tester.pumpWidget(MaterialApp(home: testConfigWidget));

          final driver = testContainerDrivableWidget.driver;
          expect(driver.runtimeType, TestContainerTestDriver);
        });

        testWidgets('Uses real driver when test config does not allow test driver', (WidgetTester tester) async {
          final testContainerDrivableWidget = TestContainerDrivableWidget(
            environmentInfo: _mockRuntimeEnvironmentInfo,
          );
          final testConfigWidget = WidgetDriverTestConfigProvider(
            config: AlwaysUseRealDriversTestConfig(),
            child: testContainerDrivableWidget,
          );
          await tester.pumpWidget(MaterialApp(home: testConfigWidget));

          final driver = testContainerDrivableWidget.driver;
          expect(driver.runtimeType, TestContainerDriver);
        });
      });
    });

    group('Driver Access:', () {
      setUp(() {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
      });

      testWidgets('Can access its driver', (WidgetTester tester) async {
        final testContainerDrivableWidget = TestContainerDrivableWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
        );
        await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

        final driver = testContainerDrivableWidget.driver;
        expect(driver.aTestText, 'A test text');
      });
    });

    group('Providable Properties:', () {
      setUp(() {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
      });

      testWidgets('Calling aTestMethod on driver makes widget reload with new data', (WidgetTester tester) async {
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

      testWidgets('didUpdateProvidedProperties gets called on widget configuration change',
          (WidgetTester tester) async {
        late TestContainerDriver driver;
        final testContainerDrivableWidget = WrappedTestContainer(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          driverCallback: (newDriver) => driver = newDriver,
        );
        await tester.pumpWidget(testContainerDrivableWidget);
        final firstDriver = driver;

        expect(driver.numberOfCallsToUpdateDriverProvidedProperties, 0);
        expect(driver.someData, 0);
        expect(find.text('justSomeData: 0'), findsOneWidget);

        await _tapButtonToIncreaseSomeData(tester);

        expect(driver.numberOfCallsToUpdateDriverProvidedProperties, 1);
        expect(driver.someData, 1);
        expect(find.text('justSomeData: 1'), findsOneWidget);
        expect(identical(driver, firstDriver), isTrue);
      });
    });

    group('BuildContext updates:', () {
      setUp(() {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
      });

      testWidgets(
          'Only calls didUpdateBuildContext 1 time (after construction), if there are no registered buildContext dependencies',
          (tester) async {
        late TestContainerDriver driver;
        final testContainerDrivableWidget = WrappedTestContainer(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          driverCallback: (newDriver) => driver = newDriver,
          readFromContext: false,
          watchFromContext: false,
        );
        await tester.pumpWidget(testContainerDrivableWidget);
        final firstDriver = driver;

        expect(driver.numberOfCallsToUpdateBuildContext, 1);

        await _tapButtonToIncreaseSomeData(tester);

        expect(driver.numberOfCallsToUpdateBuildContext, 1);
        expect(identical(driver, firstDriver), isTrue);
      });

      testWidgets('Only calls didUpdateBuildContext 1 time (after construction), if we only read from buildContext',
          (tester) async {
        late TestContainerDriver driver;
        final testContainerDrivableWidget = WrappedTestContainer(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          driverCallback: (newDriver) => driver = newDriver,
          readFromContext: true,
          watchFromContext: false,
        );
        await tester.pumpWidget(testContainerDrivableWidget);
        final firstDriver = driver;

        expect(driver.numberOfCallsToUpdateBuildContext, 1);
        expect(driver.readDataValue, 0);

        await _tapButtonToIncreaseSomeData(tester);

        expect(driver.numberOfCallsToUpdateBuildContext, 1);
        // Should still be zero since we are not watching anything from build context.
        // So the driver does not get updated.
        expect(driver.readDataValue, 0);
        expect(identical(driver, firstDriver), isTrue);
      });

      testWidgets(
          'Only calls didUpdateBuildContext 1 time (after construction), if we watch buildContext but it never changes',
          (tester) async {
        late TestContainerDriver driver;
        final testContainerDrivableWidget = WrappedTestContainer(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          driverCallback: (newDriver) => driver = newDriver,
          readFromContext: false,
          watchFromContext: true,
        );
        await tester.pumpWidget(testContainerDrivableWidget);
        final firstDriver = driver;

        expect(driver.numberOfCallsToUpdateBuildContext, 1);
        expect(driver.watchDataValue, 0);

        await _tapButtonWhichDoesNothingJustCallsSetState(tester);

        expect(driver.numberOfCallsToUpdateBuildContext, 1);
        expect(driver.watchDataValue, 0);
        expect(identical(driver, firstDriver), isTrue);
      });

      testWidgets('Calls didUpdateBuildContext more times, if we watch buildContext and it changes', (tester) async {
        late TestContainerDriver driver;
        final testContainerDrivableWidget = WrappedTestContainer(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          driverCallback: (newDriver) => driver = newDriver,
          readFromContext: false,
          watchFromContext: true,
        );
        await tester.pumpWidget(testContainerDrivableWidget);
        final firstDriver = driver;

        expect(driver.numberOfCallsToUpdateBuildContext, 1);
        expect(driver.watchDataValue, 0);

        await _tapButtonToIncreaseSomeData(tester);

        expect(driver.numberOfCallsToUpdateBuildContext, 2);
        expect(driver.watchDataValue, 1);
        expect(identical(driver, firstDriver), isTrue);

        await _tapButtonToIncreaseSomeData(tester);

        expect(driver.numberOfCallsToUpdateBuildContext, 3);
        expect(driver.watchDataValue, 2);
        expect(identical(driver, firstDriver), isTrue);
      });
    });
  });
}

class AlwaysUseTestDriverTestConfig implements WidgetDriverTestConfig {
  @override
  bool useTestDriver<Driver extends WidgetDriver>() => true;
}
