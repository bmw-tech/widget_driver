import 'package:flutter/material.dart';
import 'utils/runtime_environment_info.dart';

/// You can use this class to resolve dependencies in your widgets/drivers.
/// This class offers 2 approaches to help you write better tests:
///
/// First:
/// If you resolve dependencies in your widgets, then this class adds a safe way to resolve these dependencies
/// during testing where ancestor widgets are not forced to provide a mocked instances of your dependencies.
/// This is done with the use of Test Default Values.
///
/// Second:
/// If you resolve dependencies in your drivers where you don't know exactly how to inject override/mock values for these
/// dependencies, then this class helps you provide an easy way to inject these dependencies during testing.
///
///
/// How it works:
/// When you are not running tests, then the [DependencyResolver] will just
/// get the dependency instance according to the provided builder method.
///
/// But, during testing the [DependencyResolver] will do this:
///
/// 1: First it will check if someone registered a custom instance for the given type
/// using the [tryToGetDependencyFromBuildContext] method. If so then that is used and returned.
/// --> You can use this approach to inject mock values.
///
/// 2: If no mock override was provided, then it will try to get the dependency instance using your builder.
/// If that works and the dependency could be resolved, then it gets returned.
///
/// 3: If the normal builder fails to resolve the real dependency, then as a final step, the the [DependencyResolver]
/// will check if there is a registered test default builder for the given dependency.
/// If that exists, then it tries run that builder and return the value.
/// If there is no registered test default builder, then the original error is thrown.
///
///
/// Examples:
///
/// 1 - Widget Example:
///
/// This is how you use this in your widget where you resolve dependencies:
/// Step one: At the bottom of your widget class, create a subclass of [DependencyResolver] and implement the
/// [registerTestDefaultFallbackValues] method. In this method you register the test default instances.
/// This should be an "empty implementation" instance. Like a mock object.
/// You typically would only have one concrete implementation of [DependencyResolver] per widget where you use it.
///
/// ```dart
/// class MyServiceProviderWidget extends StatelessWidget {
///     ...
/// }
///
/// // Here we create the concrete implementation of `DependencyResolver`
/// class _Resolver extends DependencyResolver {
///     @override
///     void registerTestDefaultFallbackValues() {
///         registerTestDefaultBuilder<MyService>(() => TestDefaultMyService());
///     }
///     ...
/// }
///
/// class TestDefaultMyService extends EmptyDefault implements TestDefaultMyService {}
/// ```
///
/// And then you use this concrete version of [DependencyResolver] in your widget to create that instance.
/// Like this:
///
/// ```dart
/// class MyServiceProviderWidget extends StatelessWidget {
///     ...
///     @override
///     Widget build(BuildContext context) {
///         return Provider(
///             create: _Resolver(context).get(() => MyService(someStuffFromContext: context.read<SomeStuff>())),
///             child: child,
///         );
///     }
/// }
/// ```
///
/// Now when you run this normally as a flutter app, then the real `MyService` will be created.
/// And it will try to get the real `SomeStuff` instance out of the build context.
///
/// BUT: if you run this during tests, and you never registered any type for `SomeStuff` in the buildContext.
/// Normally, this would break your test build and throw an exception. In this case however, we will use your
/// test default instance of your `MyService`, provided in the [registerTestDefaultBuilder] method.
/// This is useful since it simplifies the WidgetTesting for any ancestor widget which might have your widget
/// as a child. Since normally, all ancestor widgets would need to provide all the dependencies to all their children.
/// Using this approach how ever, in testing, your ancestor
/// widgets can just ignore dependencies which their children need.
///
///
/// 2 - Driver Example:
///
/// This is how you use this in your drivers when you resolve dependencies
/// where you have no control over how they get injected:
///
/// Say for example that your driver needs access to a localized text and you do something like this:
/// `final someText = AppLocalizations.of(context)!.someText;`
///
/// Then when you are testing this driver, this will throw an exception since it cannot find the localization.
/// The normal fix would be to provide the mock localization using the normal flutter approach, which means you need
/// to create a lot of logic above your driver and wrap it in some localization providing widget.
/// This adds a lot of clutter-setup-mock-code to your driver tests.
///
/// The [DependencyResolver] can help you here. Create a shared [DependencyResolver] and override the
/// [tryToGetDependencyFromBuildContext] method, and in there, for example use the Provider package like this:
///
/// ```dart
/// class Resolver extends DependencyResolver {
///   @override
///   T? tryToGetDependencyFromBuildContext<T>(BuildContext context) {
///     try {
///       return context.read<T>();
///     } catch (_) {}
///       return null;
///     }
///   }
///   ...
/// }
/// ```
///
/// Now you can change your driver code where you try to get the localized text and do this:
/// `final someText = Resolver(context).get(() => AppLocalizations.of(context)!.someText);`
///
/// When running this code normally it works just like before.
/// But when you run this in tests, it now becomes a lot easier to inject a mocked version of the localization.
/// Since now you just need to put a `Provider<TheType>.value(value: MockedTheType, child: driverWidget)` when
/// you create your driver in the driver tests.
abstract class DependencyResolver {
  final RuntimeEnvironmentInfo _environmentInfo;
  final BuildContext _context;

  bool _didCallSetupTestValues = false;

  final _defaultTestValueMap = <dynamic, dynamic>{};

  DependencyResolver(
    BuildContext context, {
    RuntimeEnvironmentInfo? environmentInfo,
  })  : _context = context,
        _environmentInfo = environmentInfo ?? RuntimeEnvironmentInfo();

  /// When running normally (outside of tests) this returns the instance which your builder returns.
  ///
  /// During tests, this tries to return a mocked version if it exists.
  /// If there is no mock then it tries to return the instance which your builder returns.
  ///
  /// But if this fails for some reason (e.g. you did not provide a mock version of that type),
  /// then it tries to return the registered test default value for the given type.
  ///
  /// Finally, if there is no test default value,
  /// then this method throws the exception which was thrown by the builder method.
  T get<T>(T Function() builder) {
    final isRunningInTest = _environmentInfo.isRunningInTestEnvironment();

    if (isRunningInTest) {
      final buildContextInstance = tryToGetDependencyFromBuildContext<T>(_context);
      if (buildContextInstance != null) {
        return buildContextInstance;
      }
    }

    try {
      final T value = builder();
      return value;
    } catch (error) {
      // No dependency could be loaded from the provided builder.
      // Probably since the builder tries to access a dependency from the BuildContext which was not there.
      // This is a common issue when ancestor widgets renders child widgets which tries to resolve dependencies.
      // If we are running tests, then try to return the test default value.
      if (isRunningInTest) {
        final testDefaultInstance = _tryToGetTestDefaultInstance<T>();
        if (testDefaultInstance != null) {
          return testDefaultInstance;
        }
      }
      rethrow;
    }
  }

  /// Override this method to register all the test default values which you need.
  ///
  /// For example if you want to get the dependencies for 2 types: `MyService` and `ThemeData`
  /// then you would add this implementation to your override:
  ///
  /// ```dart
  /// class _Resolver extends DependencyResolver {
  ///     @override
  ///     void registerTestDefaultFallbackValues() {
  ///         registerTestDefaultBuilder<MyService>(() => TestDefaultMyService());
  ///         registerTestDefaultBuilder<ThemeData>(() => TestDefaultThemeData());
  ///     }
  /// }
  /// ```
  ///
  /// where the `TestDefaultMyService` and `TestDefaultThemeData` are some empty/mock-like fake implementations.
  @protected
  void registerTestDefaultFallbackValues();

  /// Call this to register a builder which creates a test default instance for a given type.
  /// This builder/created-instance is used in testing when the normal
  /// `DependencyResolver-get` method fails to create your dependency.
  @protected
  void registerTestDefaultBuilder<T>(T Function() builder) {
    _defaultTestValueMap[T] = builder;
  }

  /// Override this method to provide an approach to look up the dependency in the build context.
  ///
  /// For example if you want to use the Provider package you might do something like this:
  ///
  /// ```dart
  /// class Resolver extends DependencyResolver {
  ///     @override
  ///     T? tryToGetDependencyFromBuildContext<T>(BuildContext context) {
  ///        try {
  ///           return context.read<T>();
  ///        } catch (_) {}
  ///           return null;
  ///        }
  ///     }
  /// }
  /// ```
  @protected
  T? tryToGetDependencyFromBuildContext<T>(BuildContext context);

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
