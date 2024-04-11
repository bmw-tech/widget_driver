import 'package:widget_driver/widget_driver.dart';

part 'playground_test_child_widget_driver.g.dart';

@GenerateTestDriver()
class PlaygroundTestChildWidgetDriver extends WidgetDriver {
  String get theText => 'Text coming from RealDriver';
}
