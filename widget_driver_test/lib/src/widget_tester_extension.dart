import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widget_driver_test.dart';
import 'utils/test_drivable_widget.dart';

typedef WidgetBuilder = Widget Function(Widget driverWidget);

/// Provides functionality to help you test your [WidgetDriver]s.
extension Driver on WidgetTester {
  /// Returns a [DriverTester] for a given type of [WidgetDriver].
  /// Use this when you unit test your [WidgetDriver]s.
  /// It makes it easier to get a valid instance of the [WidgetDriver] and
  /// the [DriverTester] contains helper methods which e.g. lets you await the ´notifyWidgets()` calls.
  ///
  /// You need to provide a [driverBuilder] which will build your [WidgetDriver].
  ///
  /// Optionally you can also provide a [parentWidgetBuilder], this is useful if your
  /// driver needs to resolve dependencies via the [BuildContext].
  /// If that is the case, then the [parentWidgetBuilder] should create a widget which includes
  /// those dependencies. E.g. if you are using the `Provider` package, then your code might look like this:
  ///
  /// ```dart
  /// final driverTester = await tester.getDriverTester<LogInOutButtonDriver>(
  ///     driverBuilder: (context) => LogInOutButtonDriver(context),
  ///     parentWidgetBuilder: (driverWidget) {
  ///         return MultiProvider(
  ///             providers: [
  ///                 Provider<Localization>.value(value: mockLocalization),
  ///                 Provider<AuthService>.value(value: mockAuthService),
  ///             ],
  ///             child: driverWidget,
  ///         );
  ///     });
  /// final driver = driverTester.driver;
  /// ```
  Future<DriverTester<T>> getDriverTester<T extends WidgetDriver>({
    required T Function(BuildContext context) driverBuilder,
    WidgetBuilder? parentWidgetBuilder,
  }) async {
    TestDrivableWidget<T> drivableWidget = TestDrivableWidget<T>(
      driverBuilder: driverBuilder,
    );
    Widget widget = drivableWidget;
    if (parentWidgetBuilder != null) {
      widget = parentWidgetBuilder(drivableWidget);
    }
    await pumpWidget(widget);

    return DriverTester<T>(drivableWidget.driver, this);
  }
}
