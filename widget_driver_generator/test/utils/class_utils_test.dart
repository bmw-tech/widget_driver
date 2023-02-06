import 'package:test/test.dart';

import 'package:widget_driver_generator/src/utils/class_utils.dart';

void main() {
  group('ClassUtils:', () {
    test('Returns correct testDriverClassName', () {
      const className = 'ExampleDriver';
      const expected = '_\$Test$className';
      final actual = ClassUtils.testDriverClassName(className);
      expect(actual, expected);
    });
    test('Returns correct driverProviderClassName', () {
      const className = 'ExampleDriver';
      const expected = '\$${className}Provider';
      final actual = ClassUtils.driverProviderClassName(className);
      expect(actual, expected);
    });
  });
}
