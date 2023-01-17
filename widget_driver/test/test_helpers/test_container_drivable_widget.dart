import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

/// This is a Driver used by the unit tests.
/// Since `WidgetDriver` is just an abstract interface we
/// need some concrete instance which we can use in our tests.
/// This is the driver which is driving the `TestContainerDrivableWidget`.
class TestContainerDriver extends WidgetDriver {
  TestContainerDriver(BuildContext context) : super(context);

  String get aTestText => 'A test text';

  bool didCallTestMethod = false;
  void aTestMethod() {
    didCallTestMethod = true;
    notifyWidget();
  }
}

/// This is the TestDriver version of the `TestContainerDriver`.
/// This driver will be created by the `TestContainerDrivableWidget` when
/// the we are running in a test environment.
class TestContainerTestDriver extends TestDriver implements TestContainerDriver {
  @override
  String get aTestText => 'TestDriver test text';

  @override
  bool didCallTestMethod = false;

  @override
  void aTestMethod() {}
}

/// This is the provider used by `TestContainerDrivableWidget`
/// to create the correct drivers for it.
class TestContainerDriverProvider extends WidgetDriverProvider<TestContainerDriver> {
  @override
  TestContainerDriver buildDriver(BuildContext context) {
    return TestContainerDriver(context);
  }

  @override
  TestContainerDriver buildTestDriver() {
    return TestContainerTestDriver();
  }
}

/// This is a DrivableWidget used by the unit tests.
/// Since `DrivableWidget` is just an abstract interface we
/// need some concrete instance which we can use in our tests.
/// The driver which drives this widget is a `TestContainerDriver`.
class TestContainerDrivableWidget extends DrivableWidget<TestContainerDriver> {
  TestContainerDrivableWidget({
    Key? key,
    RuntimeEnvironmentInfo? environmentInfo,
  }) : super(key: key, environmentInfo: environmentInfo);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(driver.aTestText),
        Text('didCallTestMethod: ${driver.didCallTestMethod}'),
      ],
    );
  }

  @override
  WidgetDriverProvider<TestContainerDriver> get driverProvider => TestContainerDriverProvider();
}
