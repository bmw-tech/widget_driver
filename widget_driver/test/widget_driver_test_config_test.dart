import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';

import 'test_helpers/build_context_provider.dart';

void main() {
  group('WidgetDriverTestConfigProvider:', () {
    testWidgets('Returns test config when it is provided', (WidgetTester tester) async {
      final buildContextProvider = BuildContextProvider(
        tester,
        dependencyProviderWidget: (childWidget) => WidgetDriverTestConfigProvider(
          config: AlwaysUseRealDriversTestConfig(),
          child: childWidget,
        ),
      );

      await buildContextProvider.performAction((context) {
        final testConfig = WidgetDriverTestConfigProvider.of(context);
        expect(testConfig, isNotNull);
        expect(testConfig is AlwaysUseRealDriversTestConfig, isTrue);
      });
    });

    testWidgets('Returns null when no test config is provided', (WidgetTester tester) async {
      final buildContextProvider = BuildContextProvider(
        tester,
        dependencyProviderWidget: (childWidget) => childWidget,
      );

      await buildContextProvider.performAction((context) {
        final testConfig = WidgetDriverTestConfigProvider.of(context);
        expect(testConfig, isNull);
      });
    });
  });

  group('AlwaysUseRealDriversTestConfig:', () {
    test('returns false for useTestDriver', () {
      final testConfig = AlwaysUseRealDriversTestConfig();
      expect(testConfig.useTestDriver(), isFalse);
    });
  });

  group('UseRealDriversForSomeTestConfig:', () {
    test('returns false for useTestDriver when driver should use real driver', () {
      final testConfig = UseRealDriversForSomeTestConfig(useRealDriversFor: {_TestDriver1});
      expect(testConfig.useTestDriver<_TestDriver1>(), isFalse);
    });

    test('returns true for useTestDriver when driver should not use real driver', () {
      final testConfig = UseRealDriversForSomeTestConfig(useRealDriversFor: {_TestDriver1});
      expect(testConfig.useTestDriver<_TestDriver2>(), isTrue);
    });
  });
}

class _TestDriver1 extends WidgetDriver {}

class _TestDriver2 extends WidgetDriver {}
