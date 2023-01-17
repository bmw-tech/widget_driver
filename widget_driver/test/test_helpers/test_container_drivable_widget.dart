import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

class TestContainerDriver extends WidgetDriver {
  TestContainerDriver(BuildContext context) : super(context);

  String get aTestText => 'A test text';

  bool didCallTestMethod = false;
  void aTestMethod() {
    didCallTestMethod = true;
    notifyWidget();
  }
}

class TestContainerTestDriver extends TestDriver
    implements TestContainerDriver {
  @override
  String get aTestText => 'TestDriver test text';

  @override
  bool didCallTestMethod = false;

  @override
  void aTestMethod() {}
}

class TestContainerDriverProvider
    extends WidgetDriverProvider<TestContainerDriver> {
  @override
  TestContainerDriver buildDriver(BuildContext context) {
    return TestContainerDriver(context);
  }

  @override
  TestContainerDriver buildTestDriver() {
    return TestContainerTestDriver();
  }
}

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
  WidgetDriverProvider<TestContainerDriver> get driverProvider =>
      TestContainerDriverProvider();
}
