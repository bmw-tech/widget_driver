import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'test_runtime_environment_info.dart';
import 'test_widget_driver_provider.dart';

/// This is a helper widget which is used by the `WidgetTester`
/// extension to help with the creation of a driver.
/// This widget will be used as a container for your driver.
/// It makes sure that your driver is created and disposed correctly.
class TestDrivableWidget<T extends WidgetDriver> extends DrivableWidget<T> {
  final T Function() _driverBuilder;

  TestDrivableWidget({
    Key? key,
    required T Function() driverBuilder,
  })  : _driverBuilder = driverBuilder,
        super(key: key, environmentInfo: TestRuntimeEnvironmentInfo());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  WidgetDriverProvider<T> get driverProvider => TestWidgetDriverProvider<T>(driverBuilder: _driverBuilder);
}
