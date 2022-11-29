import 'package:flutter/widgets.dart';

import '../widget_driver.dart';

/// A widget you can use to provide a mock driver to your [DrivableWidget]s when you are testing them
///
/// When your widget is being tested and you provided a mocked version of the driver using the [MockDriverProvider]
/// then that mocked driver version will be used. If you do not provide a mocked driver via [MockDriverProvider] then
/// the hard coded [TestDriver] will always be used.
///
/// Here is an example of how you can use this in your [WidgetTests]:
///
/// ```dart
/// final myWidget = MockDriverProvider<MyWidgetDriver>(
///    value: mockMyWidgetDriver,
///    child: MyWidget(),
/// );
/// ...
/// await tester.pumpWidget(myWidget);
/// ```
///
@visibleForTesting
class MockDriverProvider<Driver extends WidgetDriver> extends InheritedWidget {
  const MockDriverProvider({
    Key? key,
    required Driver value,
    required Widget child,
  })  : _value = value,
        super(key: key, child: child);

  final Driver _value;

  /// Resolves the mocked driver out from the [BuildContext].
  /// If no mocked driver was provided, then it returns `null`
  static Driver? of<Driver extends WidgetDriver>(BuildContext context) {
    final mockProvider = context.dependOnInheritedWidgetOfExactType<MockDriverProvider<Driver>>();
    return mockProvider?._value;
  }

  @override
  bool updateShouldNotify(MockDriverProvider oldWidget) {
    return oldWidget._value != _value;
  }
}
