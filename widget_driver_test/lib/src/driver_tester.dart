import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';

class DriverTester<T extends WidgetDriver> {
  final T driver;

  final WidgetTester _widgetTester;

  int _notifyWidgetsCallCount = 0;
  int _lastWaitForNotifyWidgetCount = 0;

  List<_CompleterContainer> _completers = [];

  DriverTester(this.driver, WidgetTester widgetTester) : _widgetTester = widgetTester {
    driver.addListener(() {
      _notifyWidgetsCallCount += 1;
      _validateCompleters();
    });
  }

  Future<void> waitForNotifyWidget({
    int numberOfCalls = 1,
    Duration timeout = const Duration(seconds: 1),
    bool requireExactNumberOfCalls = false,
  }) async {
    int expectedCount = _lastWaitForNotifyWidgetCount + numberOfCalls;

    var completer = Completer<void>();
    _completers.add(_CompleterContainer(completer, expectedCount, requireExactNumberOfCalls));

    _validateCompleters();

    return _widgetTester.runAsync(() async {
      await completer.future.timeout(
        timeout,
        onTimeout: () {
          throw 'waitForNotifyWidget timed out! Not enough calls to `notifyWidget()` received';
        },
      );
    });
  }

  Future<void> verifyNoMoreCallsToNotifyWidget({
    Duration timeout = const Duration(seconds: 1),
  }) {
    var completer = Completer<void>();
    return _widgetTester.runAsync(() async {
      await completer.future.timeout(
        timeout,
        onTimeout: () {
          // Now check if we got any more calls to `notifyWidget`
          if (_lastWaitForNotifyWidgetCount < _notifyWidgetsCallCount) {
            final extraCalls = _notifyWidgetsCallCount - _lastWaitForNotifyWidgetCount;
            final errorString = 'Still received calls to `notifyWidget()`. $extraCalls extra calls received.';
            throw errorString;
          }
        },
      );
    });
  }

  void _validateCompleters() {
    _completers.removeWhere((completerContainer) {
      final requireExactNumberOfCalls = completerContainer.requireExactNumberOfCalls;
      final neededCallsToNotifyWidget = completerContainer.minCallsToNotifyWidget;

      if (neededCallsToNotifyWidget <= _notifyWidgetsCallCount) {
        if (requireExactNumberOfCalls && neededCallsToNotifyWidget < _notifyWidgetsCallCount) {
          final extraCalls = _notifyWidgetsCallCount - neededCallsToNotifyWidget;
          final errorString = '''
Received too many calls to `notifyWidget()`. 
$extraCalls extra calls received. Either set `requireExactNumberOfCalls` 
for false or investigate why you got these extra calls
''';
          completerContainer.completer.completeError(errorString);
          return true;
        } else {
          _lastWaitForNotifyWidgetCount = neededCallsToNotifyWidget;
          completerContainer.completer.complete();
          return true;
        }
      }
      return false;
    });
  }
}

class _CompleterContainer {
  final Completer completer;
  final int minCallsToNotifyWidget;
  final bool requireExactNumberOfCalls;

  _CompleterContainer(
    this.completer,
    this.minCallsToNotifyWidget,
    this.requireExactNumberOfCalls,
  );
}
