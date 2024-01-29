import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

/// A widget you can use to provide a test configuration to your [DrivableWidget]s when you are testing them.
///
/// When your widget is being tested and you provided a test config using the [WidgetDriverTestConfigProvider]
/// then that test config will be used by the [WidgetDriver] framework to decide how to set up your Drivers.
///
/// Here is an example of how you can use this in your [WidgetTests] to use real drivers for all Drivers:
///
/// ```dart
/// final myWidget = WidgetDriverTestConfigProvider(
///    config: AlwaysUseRealDriversTestConfig(),
///    child: MyWidget(),
/// );
/// ...
/// await tester.pumpWidget(myWidget);
/// ```
///
/// And here is an example of how you can use this in your [WidgetTests] to use real drivers for some Drivers:
///
/// ```dart
/// final myWidget = WidgetDriverTestConfigProvider(
///    config: UseRealDriversForSomeTestConfig(useRealDriversFor: {MyWidgetDriver}),
///    child: MyWidget(),
/// );
/// ...
/// await tester.pumpWidget(myWidget);
/// ```
///
@visibleForTesting
class WidgetDriverTestConfigProvider extends InheritedWidget {
  const WidgetDriverTestConfigProvider({
    Key? key,
    required WidgetDriverTestConfig config,
    required Widget child,
  })  : _config = config,
        super(key: key, child: child);

  final WidgetDriverTestConfig _config;

  /// Resolves the test config out from the [BuildContext].
  /// If no test config was provided, then it returns `null`
  static WidgetDriverTestConfig? of(BuildContext context) {
    final testConfigProvider = context.dependOnInheritedWidgetOfExactType<WidgetDriverTestConfigProvider>();
    return testConfigProvider?._config;
  }

  @override
  bool updateShouldNotify(WidgetDriverTestConfigProvider oldWidget) {
    return oldWidget._config != _config;
  }
}

/// Base class for defining test configuration for the [WidgetDriver] framework which is used during testing.
@visibleForTesting
abstract class WidgetDriverTestConfig {
  bool useTestDriver<Driver extends WidgetDriver>();
}

/// Use this class in your WidgetDriver tests to always use real drivers and never use any test drivers.
@visibleForTesting
class AlwaysUseRealDriversTestConfig implements WidgetDriverTestConfig {
  @override
  bool useTestDriver<Driver extends WidgetDriver>() => false;
}

/// Use this class in your WidgetDriver tests to use real drivers for some drivers.
/// You can specify for which drivers you want to use the real driver by passing
/// in the Type of these drivers into the `useRealDriversFor` parameter.
///
/// For example, if you only want to use the real driver for a driver class named `MyCoolDriver`,
/// then you would type this:
///
/// ```dart
/// UseRealDriversForSomeTestConfig(useRealDriversFor: {MyCoolDriver})
/// ```
///
/// Then any driver created during the testing will use a [TestDriver] unless the driver is of type `MyCoolDriver`.
/// For all the `MyCoolDriver`, the real `MyCoolDriver` driver will be used instead.
@visibleForTesting
class UseRealDriversForSomeTestConfig implements WidgetDriverTestConfig {
  UseRealDriversForSomeTestConfig({
    required Set<Type> useRealDriversFor,
  }) : _useRealDriverForTheseDrivers = useRealDriversFor;

  final Set<Type> _useRealDriverForTheseDrivers;

  @override
  bool useTestDriver<Driver extends WidgetDriver>() {
    if (_useRealDriverForTheseDrivers.contains(Driver)) {
      return false;
    }
    return true;
  }
}
