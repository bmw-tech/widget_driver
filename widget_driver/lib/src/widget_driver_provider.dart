import 'package:flutter/material.dart';

import 'flow_coordinator.dart';
import 'widget_driver.dart';

abstract class WidgetDriverProvider<Driver extends WidgetDriver<FlowCoordinator>> {
  Driver buildDriver(BuildContext context);
  Driver buildTestDriver();
}
