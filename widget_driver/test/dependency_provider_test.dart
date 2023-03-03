import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:mocktail/mocktail.dart';

class _MockRuntimeEnvironmentInfo extends Mock implements RuntimeEnvironmentInfo {}

// ignore_for_file: prefer_function_declarations_over_variables

void main() {
  group('DependencyProvider:', () {
    late _MockRuntimeEnvironmentInfo _mockRuntimeEnvironmentInfo;
    late DependencyProvider sut;

    setUp(() {
      _mockRuntimeEnvironmentInfo = _MockRuntimeEnvironmentInfo();
    });

    group('When not running tests:', () {
      setUp(() {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
      });
      group('When no TestDefault is registered:', () {
        setUp(() {
          sut = _TestingDependencyProviderWithoutTestDefaults(environmentInfo: _mockRuntimeEnvironmentInfo);
        });

        test('Returns dependency from builder when builder does not throw.', () {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final myStringDependency = sut.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        test('Throws original exception when builder does throw.', () {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          try {
            sut.get(() => stringBuilder());
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });

      group('When TestDefault is registered:', () {
        setUp(() {
          sut = _TestingDependencyProviderWithTestDefaults(environmentInfo: _mockRuntimeEnvironmentInfo);
        });

        test('Returns dependency from builder when builder does not throw.', () {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final myStringDependency = sut.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        test('Throws original exception when builder does throw.', () {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          try {
            sut.get(() => stringBuilder());
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });
    });

    group('When running tests:', () {
      setUp(() {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(true);
      });
      group('When no TestDefault is registered:', () {
        setUp(() {
          sut = _TestingDependencyProviderWithoutTestDefaults(environmentInfo: _mockRuntimeEnvironmentInfo);
        });

        test('Returns dependency from builder when builder does not throw.', () {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final myStringDependency = sut.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        test('Throws original exception when builder does throw.', () {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          try {
            sut.get(() => stringBuilder());
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });

      group('When TestDefault is registered:', () {
        setUp(() {
          sut = _TestingDependencyProviderWithTestDefaults(environmentInfo: _mockRuntimeEnvironmentInfo);
        });

        test('Returns dependency from builder when builder does not throw.', () {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final myStringDependency = sut.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        test('Returns TestDefault when builder does throw.', () {
          final String Function() stringBuilder = () {
            throw Exception('Dependency could not be created');
          };

          final myStringDependency = sut.get(() => stringBuilder());

          expect(myStringDependency, equals('TestDefaultString'));
        });
      });
    });
  });
}

class _TestingDependencyProviderWithoutTestDefaults extends DependencyProvider {
  _TestingDependencyProviderWithoutTestDefaults({
    RuntimeEnvironmentInfo? environmentInfo,
  }) : super(environmentInfo: environmentInfo);

  @override
  void registerTestDefaultFallbackValues() {}
}

class _TestingDependencyProviderWithTestDefaults extends DependencyProvider {
  _TestingDependencyProviderWithTestDefaults({
    RuntimeEnvironmentInfo? environmentInfo,
  }) : super(environmentInfo: environmentInfo);

  @override
  void registerTestDefaultFallbackValues() {
    registerTestDefaultBuilder<String>(() => 'TestDefaultString');
  }
}
