import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/src/utils/platform_environment.dart';

void main() {
  group('PlatformEnvironment:', () {
    late Map<String, String> _mockEnvironment;
    late GetEnvironment _mockGetEnvironment;

    setUp(() {
      _mockEnvironment = {};
      _mockGetEnvironment = (() => _mockEnvironment);
    });

    group('When not web:', () {
      test('Returns true when environment contains key', () {
        _mockEnvironment = {'SomeKey': 'SomeValue'};
        final platformEnvironment = PlatformEnvironment(
          isWeb: false,
          getEnvironment: _mockGetEnvironment,
        );
        expect(platformEnvironment.containsKey('SomeKey'), true);
      });

      test('Returns false when environment does not contains key', () {
        _mockEnvironment = {'SomeOtherKey': 'SomeOtherValue'};
        final platformEnvironment = PlatformEnvironment(
          isWeb: false,
          getEnvironment: _mockGetEnvironment,
        );
        expect(platformEnvironment.containsKey('SomeKey'), false);
      });
    });

    group('When web:', () {
      test('Returns false even when environment contains key', () {
        _mockEnvironment = {'SomeKey': 'SomeValue'};
        final platformEnvironment = PlatformEnvironment(
          isWeb: true,
          getEnvironment: _mockGetEnvironment,
        );
        // Since the `web` does not support using `Environment`
        // then we always get false here when running as `web`.
        expect(platformEnvironment.containsKey('SomeKey'), false);
      });

      test('Returns false when environment does not contains key', () {
        _mockEnvironment = {'SomeOtherKey': 'SomeOtherValue'};
        final platformEnvironment = PlatformEnvironment(
          isWeb: true,
          getEnvironment: _mockGetEnvironment,
        );
        expect(platformEnvironment.containsKey('SomeKey'), false);
      });
    });
  });
}
