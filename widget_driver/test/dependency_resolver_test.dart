import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:mocktail/mocktail.dart';

class _MockRuntimeEnvironmentInfo extends Mock implements RuntimeEnvironmentInfo {}

// ignore_for_file: prefer_function_declarations_over_variables

void main() {
  group('DependencyResolver:', () {
    late _MockRuntimeEnvironmentInfo _mockRuntimeEnvironmentInfo;

    setUp(() {
      _mockRuntimeEnvironmentInfo = _MockRuntimeEnvironmentInfo();
    });

    Future<DependencyResolver> _getResolver(
      WidgetTester tester, {
      required bool withTestDefaults,
      required bool withDependencyFromBuildContext,
      required bool injectDependencyInContext,
    }) async {
      late DependencyResolver resolver;
      final containerWidget = _ContainerWidget(
        injectDependencyInContext: injectDependencyInContext,
        buildMethodCallback: (context) {
          resolver = _TestingDependencyResolver(
            context,
            withTestDefaults: withTestDefaults,
            withDependencyFromBuildContext: withDependencyFromBuildContext,
            environmentInfo: _mockRuntimeEnvironmentInfo,
          );
        },
      );
      await tester.pumpWidget(containerWidget);
      return resolver;
    }

    group('When not running tests:', () {
      setUp(() {
        when(() => _mockRuntimeEnvironmentInfo.isRunningInTestEnvironment()).thenReturn(false);
      });
      group('When no TestDefault and no buildContext is registered:', () {
        testWidgets('Returns dependency from builder when builder does not throw.', (tester) async {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );
          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        testWidgets('Throws original exception when builder does throw.', (tester) async {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );

          try {
            resolver.get(() => stringBuilder());
            assert(false, 'Should not get here, Exception should have been thrown');
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });

      group('When TestDefault is registered:', () {
        testWidgets('Returns dependency from builder when builder does not throw.', (tester) async {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: true,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );
          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        testWidgets('Throws original exception when builder does throw.', (tester) async {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: true,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );

          try {
            resolver.get(() => stringBuilder());
            assert(false, 'Should not get here, Exception should have been thrown');
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });

      group('When dependency from BuildContext is registered:', () {
        testWidgets('Returns dependency from builder when builder does not throw.', (tester) async {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: true,
            injectDependencyInContext: true,
          );
          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        testWidgets('Throws original exception when builder does throw.', (tester) async {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: true,
            injectDependencyInContext: false,
          );

          try {
            resolver.get(() => stringBuilder());
            assert(false, 'Should not get here, Exception should have been thrown');
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
      group('When no TestDefault and no buildContext is registered:', () {
        testWidgets('Returns dependency from builder when builder does not throw.', (tester) async {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );
          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        testWidgets('Throws original exception when builder does throw.', (tester) async {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );

          try {
            resolver.get(() => stringBuilder());
            assert(false, 'Should not get here, Exception should have been thrown');
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });

      group('When TestDefault is registered:', () {
        testWidgets('Returns dependency from builder when builder does not throw.', (tester) async {
          const expectedStringDependency = 'Some string I want to inject';
          final String Function() stringBuilder = () {
            return expectedStringDependency;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: true,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );

          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals(expectedStringDependency));
        });

        testWidgets('Returns TestDefault when builder does throw.', (tester) async {
          final String Function() stringBuilder = () {
            throw Exception('Dependency could not be created');
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: true,
            withDependencyFromBuildContext: false,
            injectDependencyInContext: false,
          );
          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals('TestDefaultString'));
        });
      });

      group('When TestDefault is registered and dependency from context:', () {
        testWidgets('Returns dependency from BuildContext when builder does not throw.', (tester) async {
          final String Function() stringBuilder = () {
            return 'Some string I want to inject';
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: true,
            withDependencyFromBuildContext: true,
            injectDependencyInContext: true,
          );

          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals('DependencyFromContextString'));
        });

        testWidgets('Returns dependency from BuildContext when builder does throw and dependency was injected.',
            (tester) async {
          final String Function() stringBuilder = () {
            throw Exception('Dependency could not be created');
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: true,
            withDependencyFromBuildContext: true,
            injectDependencyInContext: true,
          );
          final myStringDependency = resolver.get(() => stringBuilder());

          expect(myStringDependency, equals('DependencyFromContextString'));
        });

        testWidgets('Throws original exception when builder does throw and dependency was not injected.',
            (tester) async {
          final expectedException = Exception('Dependency could not be created');
          final String Function() stringBuilder = () {
            throw expectedException;
          };

          final resolver = await _getResolver(
            tester,
            withTestDefaults: false,
            withDependencyFromBuildContext: true,
            injectDependencyInContext: false,
          );

          try {
            resolver.get(() => stringBuilder());
            assert(false, 'Should not get here, Exception should have been thrown');
          } catch (error) {
            expect(error, equals(expectedException));
          }
        });
      });
    });
  });
}

class _ContainerWidget extends StatelessWidget {
  final bool injectDependencyInContext;
  final void Function(BuildContext context) buildMethodCallback;

  const _ContainerWidget({
    Key? key,
    required this.buildMethodCallback,
    required this.injectDependencyInContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (injectDependencyInContext) {
      return Provider<String>.value(
        value: 'DependencyFromContextString',
        child: Builder(
          builder: (innerContext) {
            buildMethodCallback(innerContext);
            return Container();
          },
        ),
      );
    } else {
      buildMethodCallback(context);
      return Container();
    }
  }
}

class _TestingDependencyResolver extends DependencyResolver {
  final bool withTestDefaults;
  final bool withDependencyFromBuildContext;

  _TestingDependencyResolver(
    BuildContext context, {
    required this.withTestDefaults,
    required this.withDependencyFromBuildContext,
    RuntimeEnvironmentInfo? environmentInfo,
  }) : super(context, environmentInfo: environmentInfo);

  @override
  void registerTestDefaultFallbackValues() {
    if (withTestDefaults) {
      registerTestDefaultBuilder<String>(() => 'TestDefaultString');
    }
  }

  @override
  T? tryToGetDependencyFromBuildContext<T>(BuildContext context) {
    if (withDependencyFromBuildContext) {
      try {
        return context.read<T>();
      } catch (_) {}
    }
    return null;
  }
}
