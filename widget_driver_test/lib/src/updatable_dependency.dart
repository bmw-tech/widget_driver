import 'package:flutter/material.dart';

/// Use this class to simplify testing your Drivers which have dependencies coming
/// from the [BuildContext] and which could update and trigger that the
/// `didUpdateBuildContext` method of your driver is called.
///
/// E.g. image you have a simple driver like this:
///
/// ```dart
/// class CounterDriver extends WidgetDriver {
///   late int _counter;
///
///   @override
///   void didUpdateBuildContext(BuildContext context) {
///     _counter = context.watch<int>();
///   }
///
///   @TestDriverDefaultValue('3')
///   String get counterText => '$_counter';
/// }
/// ```
///
/// This driver watches the int value coming from the context.
/// If that value would change, then the `didUpdateBuildContext` is called again
/// by the widget_driver framework.
///
/// To make it easy to test this you can use this class like this:
///
/// ```dart
/// ValueNotifier<int> fakeCountNotifier = ValueNotifier<int>(0);
/// ...
/// final driverTester = await tester.getDriverTester(
///     driverBuilder: () => CounterDriver(),
///     parentWidgetBuilder: (driverWidget) {
///         return UpdatableDependency<int>(
///             valueNotifier: fakeCountNotifier,
///             builder: (count) {
///               return Provider<int>.value(value: count, child: driverWidget);
///             }
///         );
///     },
/// );
///
/// // The initial value was '0' when the driver was created.
/// expect(driverTester.driver.counterText, '0');
///
/// // Update the counter value and make flutter "render" the changes.
/// fakeCountNotifier.value = 123;
/// await tester.pumpAndSettle();
///
/// // Now the `didUpdateBuildContext` was called with value 123 so now the text will be '123'
/// expect(driverTester.driver.counterText, '123');
/// ```
class UpdatableDependency<T> extends StatelessWidget {
  final ValueNotifier<T> valueNotifier;
  final Widget Function(T value) builder;

  const UpdatableDependency({
    Key? key,
    required this.valueNotifier,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      builder: (BuildContext context, T value, _) {
        return builder(value);
      },
      valueListenable: valueNotifier,
    );
  }
}
