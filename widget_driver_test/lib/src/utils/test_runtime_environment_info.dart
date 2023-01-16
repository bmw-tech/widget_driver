import 'package:widget_driver/widget_driver.dart';

/// This is a wrapper around [RuntimeEnvironmentInfo] to make sure that
/// the `TestDrivableWidget` can create a real driver.
/// By default, a `DrivableWidget` will create a TestDriver when it notices
/// that a test is running.
///
/// But when we use `TestDrivableWidget` then we are running a test, but we
/// want it to still create the real driver. Since we use the
/// `TestDrivableWidget` as a container to test the real widget.
///
/// So this [TestRuntimeEnvironmentInfo] helps with that by saying the we
/// are never in a test environment. This way the `TestDrivableWidget` will
/// think it should create the real driver. Perfect :-D
class TestRuntimeEnvironmentInfo implements RuntimeEnvironmentInfo {
  @override
  bool isRunningInTestEnvironment() {
    return false;
  }
}
