import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'flow_coordinator.dart';

abstract class WidgetDriver<FC extends FlowCoordinator> {
  FC? flowCoordinator;
  final ValueNotifier<bool> _widgetNotifier = ValueNotifier<bool>(true);

  void initWithBuildContext(BuildContext context) {}

  @nonVirtual
  void notifyWidget() {
    final value = _widgetNotifier.value;
    _widgetNotifier.value = !value;
  }

  @mustCallSuper
  void dispose() {
    _widgetNotifier.dispose();
  }

  void addListener(VoidCallback listener) {
    _widgetNotifier.addListener(listener);
  }
}

class TestDriver {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }

  void initWithBuildContext(BuildContext context) {}

  void addListener(VoidCallback listener) {}

  void notifyWidget() {}

  void dispose() {}
}
