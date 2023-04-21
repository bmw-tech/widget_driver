import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'mock_driver_provider.dart';
import 'utils/runtime_environment_info.dart';
import 'widget_driver.dart';
import 'widget_driver_provider.dart';

export 'package:flutter/widgets.dart' show BuildContext;

// ignore_for_file: invalid_use_of_visible_for_testing_member

/// A base class for widgets which can be driven by a WidgetDriver.
abstract class DrivableWidget<Driver extends WidgetDriver> extends StatefulWidget {
  DrivableWidget({
    Key? key,
    RuntimeEnvironmentInfo? environmentInfo,
  })  : _environmentInfo = environmentInfo ?? RuntimeEnvironmentInfo(),
        super(key: key);

  /// The provider which knows how to create the Driver for this widget.
  WidgetDriverProvider<Driver> get driverProvider;

  /// The driver which drives this widget.
  ///
  /// Your widgets should use the `driver` to access any type of dynamic data.
  /// The idea is to put all your business logic in the driver and only have
  /// the declarative UI definition inside the widget code.
  Driver get driver => _widgetDriverContainer.instance!;

  final RuntimeEnvironmentInfo _environmentInfo;
  final _widgetDriverContainer = _WidgetDriverContainer<Driver>();

  Widget build(BuildContext context);

  @nonVirtual
  @override
  State<DrivableWidget<Driver>> createState() => _DriverWidgetState<Driver>();
}

class _DriverWidgetState<Driver extends WidgetDriver> extends State<DrivableWidget<Driver>> {
  Driver? _driver;

  @override
  void dispose() {
    _driver?.dispose();
    super.dispose();
  }

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context) {
    final driver = _getDriverAndSetupUpIfNeeded();
    widget._widgetDriverContainer.instance = driver;
    return widget.build(context);
  }

  @override
  void didUpdateWidget(covariant DrivableWidget<Driver> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_driverExists) {
      widget.driverProvider.updateDriverProvidedProperties(_driver!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_driverExists) {
      _driver!.didUpdateBuildContext(context);
    }
  }

  Driver _getDriverAndSetupUpIfNeeded() {
    if (_driverExists) {
      return _driver!;
    }

    Driver driver;
    if (_isRunningInTestEnvironment()) {
      driver = _getTestDriver();
    } else {
      driver = _getRealDriver();
    }

    driver.didUpdateBuildContext(context);

    driver.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    driver.didInitDriver();

    _driver = driver;
    return driver;
  }

  bool _isRunningInTestEnvironment() {
    var isRunningInTest = false;
    assert(() {
      isRunningInTest = widget._environmentInfo.isRunningInTestEnvironment();
      return true;
    }());
    return isRunningInTest;
  }

  Driver _getRealDriver() {
    return widget.driverProvider.buildDriver();
  }

  Driver _getTestDriver() {
    // Check if we have an injected MockDriver for the current type.
    // If it exists and it was not already assigned as current driver,
    // then update the current driver.
    final mockDriver = MockDriverProvider.of<Driver>(context);
    if (mockDriver != null) {
      return mockDriver;
    }

    // There was no mocked driver. Then just return the hard coded TestDriver.
    return widget.driverProvider.buildTestDriver();
  }

  bool get _driverExists => _driver != null;
}

class _WidgetDriverContainer<Driver extends WidgetDriver> {
  Driver? instance;
}
