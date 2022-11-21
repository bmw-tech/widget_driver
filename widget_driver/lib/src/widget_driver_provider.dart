import 'flow_coordinator.dart';
import 'widget_driver.dart';

abstract class WidgetDriverProvider<Driver extends WidgetDriver<FlowCoordinator>> {
  Driver buildDriver();
  Driver buildTestDriver();
}
