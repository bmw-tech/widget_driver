import 'utils/runtime_environment_info.dart';

/// Use this class to create/resolve dependencies in your widgets.
/// This class adds a safe way to create/resolve dependencies during testing where
/// parent widgets are not forced to provide a mocked instance of your dependency.
///
/// The `DependencyProvider` will create the dependency object
/// according to the provided builder when you are not running tests.
///
/// During testing the `DependencyProvider` will first try to create the dependency object using your builder,
/// but if this fails and throws (because for example no parent widget registered the dependency),
/// then the `DependencyProvider` will return the registered test default value.
///
/// This is how you use this in your widget where you provide dependencies:
/// Step one: At the bottom of your widget class, create a subclass of `DependencyProvider` and implement the
/// `registerTestDefaultFallbackValues` method. In this method you register the test default instance.
/// This should be an empty implementation instance. Like a mock object.
///
/// ```dart
/// class MyServiceProviderWidget extends StatelessWidget {
///     ...
/// }
///
/// class _DependencyProvider extends DependencyProvider {
///     @override
///     void registerTestDefaultFallbackValues() {
///         registerTestDefaultBuilder<MyService>(() => TestDefaultMyService());
///     }
/// }
///
/// class TestDefaultMyService extends EmptyDefault implements TestDefaultMyService {}
/// ```
///
/// And then you use this concrete version of `DependencyProvider` in your widget to create that instance.
/// Like this:
///
/// ```dart
/// class MyServiceProviderWidget extends StatelessWidget {
///     ...
///     @override
///     Widget build(BuildContext context) {
///         return Provider(
///             create: _DependencyProvider().get(() => MyService(someStuffFromContext: context.read<SomeStuff>())),
///             child: child,
///         );
///     }
/// }
/// ```
///
/// Now when you run this normally as a flutter app, then the real `MyService` will be created.
/// And it will try to real `SomeStuff` out of the build context.
/// And when you run this during tests and you registered some mock version of `SomeStuff` in the buildContext
/// then that will be used.
///
/// BUT: if you run this during tests, and you never registered any type for `SomeStuff` in the buildContext then
/// normally this would break your test build and throw an exception. But in this case it will still run.
/// It just returns the empty test default instance of your `MyService`.
///
/// So when you run any parent widget test then they do not need to be aware of your needed dependency!
abstract class DependencyProvider {
  final RuntimeEnvironmentInfo _environmentInfo;

  bool _didCallSetupTestValues = false;

  final _defaultTestValueMap = <dynamic, dynamic>{};

  DependencyProvider({
    RuntimeEnvironmentInfo? environmentInfo,
  }) : _environmentInfo = environmentInfo ?? RuntimeEnvironmentInfo();

  /// When running normally (outside of tests) this returns the instance which your builder returns.
  ///
  /// During tests, this tries to return the instance which your builder returns.
  /// But if this fails for some reason (e.g. you did not provide a mock version of that type),
  /// then this method returns the registered test default value for the given type.
  ///
  /// If you did not register a test default builder for the given type,
  /// then this method throws the exception which was thrown by the builder.
  T get<T>(T Function() builder) {
    try {
      final T value = builder();
      return value;
    } catch (error) {
      // No dependency could be loaded from the provided builder.
      // Probably since the builder tries to access a dependency from the BuildContext which was not there.
      // This is a common issue when parent widgets renders child widgets which tries to resolve dependencies.

      // If we are running tests, then try to return the test default value
      if (_environmentInfo.isRunningInTestEnvironment()) {
        final testDefaultInstance = _tryToGetTestDefaultInstance<T>();
        if (testDefaultInstance != null) {
          return testDefaultInstance;
        } else {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  /// Override this method to register all the test default values which you need.
  ///
  /// For example if you want to get the dependencies for 2 types: `MyService` and `ThemeData`
  /// then you would add this implementation to your override:
  ///
  /// ```dart
  /// class _DependencyProvider extends DependencyProvider {
  ///     @override
  ///     void registerTestDefaultFallbackValues() {
  ///         registerTestDefaultBuilder<MyService>(() => TestDefaultMyService());
  ///         registerTestDefaultBuilder<ThemeData>(() => TestDefaultThemeData());
  ///     }
  /// }
  /// ```
  ///
  /// where the `TestDefaultMyService` and `TestDefaultThemeData` are some empty/mock-like fake implementations.
  void registerTestDefaultFallbackValues();

  /// Call this to register a builder which creates a test default instance for a given type.
  /// This builder/created-instance is used in testing when the normal
  /// `DependencyProvider-get` method fails to create your dependency.
  void registerTestDefaultBuilder<T>(T Function() builder) {
    _defaultTestValueMap[T] = builder;
  }

  T? _tryToGetTestDefaultInstance<T>() {
    if (!_didCallSetupTestValues) {
      registerTestDefaultFallbackValues();
      _didCallSetupTestValues = true;
    }

    return _getRegisteredTestDefaultInstance<T>();
  }

  T? _getRegisteredTestDefaultInstance<T>() {
    final T Function()? valueBuilder = _defaultTestValueMap[T];
    if (valueBuilder != null) {
      return valueBuilder();
    }
    return null;
  }
}
