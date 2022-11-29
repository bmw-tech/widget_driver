import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';

/// This is a helper class which makes it easier to test your [WidgetDriver]s.
/// It provides you with the actual `driver` and it has helper methods which you can
/// use to verify that the `notifyWidgets()` is called corretly.
///
/// E.g. you might expect that when some service emits a new state, then your [WidgetDriver]
/// should trigger the `notifyWidgets()` and have new values for its properties.
/// The [DriverTester] will make it easier for you to verify these things.
class DriverTester<T extends WidgetDriver> {
  /// The [WidgetDriver] which you are testing.
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

  /// Call this method with an `await` to make sure that your tests waits until the
  /// expected amounts of calls to `notifyWidgets()` have been triggered.
  ///
  /// [numberOfCalls] defaults to '1'. But you can set this to the expected amount.
  /// As soon as the expected amount of `notifyWidgets()` calls have been received, then the method will continue.
  ///
  /// If the method never gets the expected amount of calls, then it will throw and break your test.
  /// You can use the [timeout] to control how long the method will wait. By default this is set to 1 seconds.
  ///
  /// Finally you can also control that you didnt get too many calls to `notifyWidgets()`.
  /// If you set the [requireExactNumberOfCalls] to `true`, then this method will verify that you got exactly
  /// [numberOfCalls] amount of calls and not more.
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

  /// Use this method to verify that no more calls to `notifyWidgets()` are made.
  /// The method will according to the [timeout] you specify. (defaults to 1 seconds).
  /// If any call to `notifyWidgets()` is made during this time
  /// then the method will throw and and break your test.
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
