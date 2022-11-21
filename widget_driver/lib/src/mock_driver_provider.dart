import 'package:flutter/widgets.dart';

import '../widget_driver.dart';

@visibleForTesting
class MockDriverProvider<Driver extends WidgetDriver> extends InheritedWidget {
  const MockDriverProvider({
    Key? key,
    required Driver value,
    required Widget child,
  })  : _value = value,
        super(key: key, child: child);

  final Driver _value;

  static Driver? of<Driver extends WidgetDriver>(BuildContext context) {
    final mockProvider = context.dependOnInheritedWidgetOfExactType<MockDriverProvider<Driver>>();
    return mockProvider?._value;
  }

  @override
  bool updateShouldNotify(MockDriverProvider oldWidget) {
    return oldWidget._value != _value;
  }
}
