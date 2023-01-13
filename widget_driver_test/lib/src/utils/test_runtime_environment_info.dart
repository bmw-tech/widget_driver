import 'package:widget_driver/widget_driver.dart';

class TestRuntimeEnvironmentInfo implements RuntimeEnvironmentInfo {
  @override
  bool isRunningInTestEnvironment() {
    return false;
  }
}
