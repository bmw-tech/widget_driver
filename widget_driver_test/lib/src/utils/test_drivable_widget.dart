import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'test_runtime_environment_info.dart';
import 'test_widget_driver_provider.dart';

class TestDrivableWidget<T extends WidgetDriver> extends DrivableWidget<T> {
  final T Function(BuildContext context) _driverBuilder;

  TestDrivableWidget({
    Key? key,
    required T Function(BuildContext context) driverBuilder,
  })  : _driverBuilder = driverBuilder,
        super(key: key, environmentInfo: TestRuntimeEnvironmentInfo());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  WidgetDriverProvider<T> get driverProvider => TestWidgetDriverProvider<T>(driverBuilder: _driverBuilder);
}
