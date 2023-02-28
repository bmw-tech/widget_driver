import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';
import 'test_helpers/test_container_drivable_widget.dart';

class _MockRuntimeEnvironmentInfo extends Mock implements RuntimeEnvironmentInfo {}

void main() {
  group('DrivableWidget:', () {
    late _MockRuntimeEnvironmentInfo _mockRuntimeEnvironmentInfo;

    setUp(() {
      _mockRuntimeEnvironmentInfo = _MockRuntimeEnvironmentInfo();
    });

    group('Runtime Environment: ', () {
      testWidgets('Uses real driver when not in test environment', (WidgetTester tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);

        final testContainerDrivableWidget = TestContainerDrivableWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
        );
        await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

        final driver = testContainerDrivableWidget.driver;
        expect(driver.runtimeType, TestContainerDriver);
      });

      testWidgets('Uses test driver when in test environment', (WidgetTester tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(true);

        final testContainerDrivableWidget = TestContainerDrivableWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
        );
        await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

        final driver = testContainerDrivableWidget.driver;
        expect(driver.runtimeType, TestContainerTestDriver);
      });
    });

    group('Driver Access: ', () {
      testWidgets('Can access its driver', (WidgetTester tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);

        final testContainerDrivableWidget = TestContainerDrivableWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
        );
        await tester.pumpWidget(MaterialApp(home: testContainerDrivableWidget));

        final driver = testContainerDrivableWidget.driver;
        expect(driver.aTestText, 'A test text');
      });
    });

    group('Providable Properties: ', () {
      testWidgets('Calling `aTestMethod` on driver makes widget reload with new data', (WidgetTester tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);

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

      testWidgets('updateDriverProvidedProperties gets called on widget configuration change',
          (WidgetTester tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);

        final testContainerDrivableWidget = WrappedTestContainer(
          environmentInfo: _mockRuntimeEnvironmentInfo,
        );
        await tester.pumpWidget(testContainerDrivableWidget);
        final driver = testContainerDrivableWidget.driver;

        expect(driver?.numberOfCallsToUpdateDriverProvidedProperties, 0);

        await tester.tap(
          find.byKey(
            const Key(
              'wrapped_test_container_button',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(driver?.numberOfCallsToUpdateDriverProvidedProperties, 1);
      });
    });

    group('Driver lifecycle', () {
      testWidgets('does not create new driver, if there are no buildContext dependencies', (tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
        var providedValue = 1;

        final provider = TestContainerDriverProvider();

        final testContainerDrivableWidget = TestContainerDrivableWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          provider: provider,
        );
        await tester.pumpWidget(
          MaterialApp(
            home: Provider.value(
              value: providedValue,
              child: testContainerDrivableWidget,
            ),
          ),
        );
        final driver = testContainerDrivableWidget.driver;

        expect(provider.driverBuiltCount, 1);

        driver.aTestMethod();
        await tester.pump();

        expect(provider.driverBuiltCount, 1);
      });

      testWidgets('does not create new driver, if we only read from buildContext', (tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);

        final provider = ReadDriverProvider();

        final readWidget = ReadWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          provider: provider,
        );
        await tester.pumpWidget(ProviderWidget(child: readWidget));

        expect(provider.driverBuiltCount, 1);
        expect(readWidget.driver.provided, 1);

        await tester.pump();

        expect(provider.driverBuiltCount, 1);
        expect(readWidget.driver.provided, 1);
      });

      testWidgets('does create new driver, if we watch buildContext', (tester) async {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);

        final provider = WatchDriverProvider();

        final watchWidget = WatchWidget(
          environmentInfo: _mockRuntimeEnvironmentInfo,
          provider: provider,
        );
        await tester.pumpWidget(ProviderWidget(child: watchWidget));

        expect(provider.driverBuiltCount, 1);
        expect(watchWidget.driver.provided, 1);

        await tester.tap(find.byKey(const Key('provider_widget_action_button')));
        await tester.pumpAndSettle();

        expect(provider.driverBuiltCount, 2);
        expect(watchWidget.driver.provided, 2);
      });
    });
  });
}
