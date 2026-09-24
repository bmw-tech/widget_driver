import 'package:flutter_test/flutter_test.dart';

import 'package:widget_driver/src/utils/runtime_environment_info.dart';

void main() {
  group('RuntimeEnvironmentInfo:', () {
    group('Is running tests:', () {
      test('Returns true when the test binding is detected', () {
        final runtimeEnvironmentInfo = RuntimeEnvironmentInfo(isRunningInTest: () => true);
        expect(runtimeEnvironmentInfo.isRunningInTestEnvironment(), true);
      });

      test('Returns false when the test binding is not detected', () {
        final runtimeEnvironmentInfo = RuntimeEnvironmentInfo(isRunningInTest: () => false);
        expect(runtimeEnvironmentInfo.isRunningInTestEnvironment(), false);
      });
    });

    group('Constructor:', () {
      testWidgets(
        'Can construct with no input parameters using real logic. Which returns true for isRunningTests',
        (tester) async {
          final runtimeEnvironmentInfo = RuntimeEnvironmentInfo();
          expect(runtimeEnvironmentInfo.isRunningInTestEnvironment(), true);
        },
      );
    });
  });
}
