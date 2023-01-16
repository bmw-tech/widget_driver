import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:widget_driver/src/utils/platform_environment.dart';
import 'package:widget_driver/src/utils/runtime_environment_info.dart';

class MockPlatformEnvironment extends Mock implements PlatformEnvironment {}

void main() {
  group('RuntimeEnvironmentInfo:', () {
    late MockPlatformEnvironment _mockPlatformEnvironment;

    setUp(() {
      _mockPlatformEnvironment = MockPlatformEnvironment();
    });

    group('Is running tests:', () {
      test('Returns true when environment says `test` key exists', () {
        when(() => _mockPlatformEnvironment.containsKey(any()))
            .thenReturn(true);
        final runtimeEnvironmentInfo = RuntimeEnvironmentInfo(
            platformEnvironment: _mockPlatformEnvironment);
        expect(runtimeEnvironmentInfo.isRunningInTestEnvironment(), true);
      });

      test('Returns false when environment says that no `test` key exists', () {
        when(() => _mockPlatformEnvironment.containsKey(any()))
            .thenReturn(false);
        final runtimeEnvironmentInfo = RuntimeEnvironmentInfo(
            platformEnvironment: _mockPlatformEnvironment);
        expect(runtimeEnvironmentInfo.isRunningInTestEnvironment(), false);
      });
    });

    group('Constructor:', () {
      test(
          'Can construct with no input parameters using real logic. Which returns true for isRunningTests',
          () {
        final runtimeEnvironmentInfo = RuntimeEnvironmentInfo();
        expect(runtimeEnvironmentInfo.isRunningInTestEnvironment(), true);
      });
    });
  });
}
