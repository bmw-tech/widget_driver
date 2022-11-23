import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'mock_driver_provider.dart';
import 'utils/flutter_runtime_environment_checker.dart';
import 'widget_driver.dart';
import 'widget_driver_provider.dart';

export 'package:flutter/widgets.dart' show BuildContext;

// ignore_for_file: invalid_use_of_visible_for_testing_member

abstract class DrivableWidget<Driver extends WidgetDriver, DriverProvider extends WidgetDriverProvider<Driver>>
    extends StatefulWidget {
  DrivableWidget({
    Key? key,
    FlutterRuntimeEnvironmentChecker? environmentChecker,
  })  : _environmentChecker = environmentChecker ?? FlutterRuntimeEnvironmentChecker(),
        super(key: key);

  DriverProvider get driverProvider;

  final FlutterRuntimeEnvironmentChecker _environmentChecker;
  final _widgetDriverContainer = _WidgetDriverContainer<Driver>();
  Driver get driver => _widgetDriverContainer.instance!;

  Widget build(BuildContext context);

  @nonVirtual
  @override
  State<DrivableWidget<Driver, DriverProvider>> createState() => _DriverWidgetState<Driver, DriverProvider>();
}

class _DriverWidgetState<Driver extends WidgetDriver, DriverProvider extends WidgetDriverProvider<Driver>>
    extends State<DrivableWidget<Driver, DriverProvider>> {
  late Driver _driver;
  bool _didCallSetUpOnDriver = false;

  @override
  void initState() {
    super.initState();
    _initWidgetDriver();
  }

  @override
  void dispose() {
    _driver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateWidgetDriverForTestEnvIfNeeded();

    if (!_didCallSetUpOnDriver) {
      _driver.setUpFromBuildContext(context);
      _didCallSetUpOnDriver = true;
    }

    widget._widgetDriverContainer.instance = _driver;
    return widget.build(context);
  }

  void _initWidgetDriver() {
    if (widget._environmentChecker.isRunningInTestEnvironment()) {
      _driver = widget.driverProvider.buildTestDriver();
    } else {
      _driver = widget.driverProvider.buildDriver();
    }

    _driver.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    widget._widgetDriverContainer.instance = _driver;
  }

  void _updateWidgetDriverForTestEnvIfNeeded() {
    // If we are not in a test environment, then just return,
    // since then we don't want to run any mock logic.
    if (widget._environmentChecker.isRunningInTestEnvironment() == false) {
      return;
    }

    // Check if we have an injected MockDriver for the current type.
    // If it exists and it was not already assinged as current driver,
    // then update the current driver.
    final mockDriver = MockDriverProvider.of<Driver>(context);
    if (mockDriver != null && !identical(_driver, mockDriver)) {
      // Dispose the old driver
      _driver.dispose();

      // Assign the new driver and hook up listener again
      _driver = mockDriver;
      _driver.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }
}

class _WidgetDriverContainer<Driver extends WidgetDriver> {
  Driver? instance;
}
