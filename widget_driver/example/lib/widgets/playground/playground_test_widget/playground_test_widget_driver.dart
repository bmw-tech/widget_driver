import 'package:widget_driver/widget_driver.dart';

part 'playground_test_widget_driver.g.dart';

@GenerateTestDriver()
class PlaygroundTestWidgetDriver extends WidgetDriver {
  String get buttonHeaderText => 'Button header text from RealDriver';
}
