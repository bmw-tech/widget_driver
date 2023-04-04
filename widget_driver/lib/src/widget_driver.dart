import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// The [WidgetDriver] is the thing which drives your widget.
///
/// This is where you put all of your business logic that is specific to a given widget.
/// You can think of the `WidgetDriver` as the `ViewModel` for the widget.
///
/// Each `Driver` is unique to a given widget. You do not share/reuse `Drivers` between many widgets.
/// Instead each widget has its own `Driver`.
///
/// The `Driver` provides all dynamic data to the widget via public properties.
/// If these properties depend on some external dependency, then these dependencies are resolved inside the `Driver` and not in the widget.
///
/// E.g. if a text in a widget depends on wether the user is logged in or not, then that `AuthService`
/// is not resolved in the widget. But instead the `Driver` resolves it and listens to changes on it.
/// And as soon as a change occurs, then the `Driver` will call its `notifyWidget()` method which will trigger the widget to update.
///
///
/// One more benefit which the `WidgetDriver` gives you is easier/better widget testing.
/// Usually when you test your widgets, then you need to provide mocked values to any dependency which any of your child widgets have.
/// This really clutters your widget test code since most of the code will end up being to define mocks.
/// It also creates tight coupling since any change you make in a child widget might end up breaking all your parent widget tests.
///
/// Here the `WidgetDriver` comes with a solution. If your widget is running in a test environment, then the `Driver` will not create
/// its "real" instance. Instead it will create a hard coded version of its self called a `TestDriver`.
/// This `TestDriver` has no dependencies. It just contains hard coded default values.
///
///
/// ### Here is a mini example of how to use the `WidgetDriver`:
///
/// ```dart
/// class RandomNumberWidgetDriver extends WidgetDriver {
///     RandomNumberService _randomNumberService = ...;
///     Localization _localization = ...;
///
///     @TestDriverDefaultValue('123')
///     int get randomNumber => _randomNumberService.theRandomNumber;
///
///     @TestDriverDefaultValue('Get new random number')
///     String get buttonText => _localization.getRandomNumberButtonText;
///
///     @TestDriverDefaultValue()
///     void updateRandomNumber() {
///         _randomNumberService.generateNewRandomNumber();
///         notifyWidget();
///     }
/// }
///
/// class RandomNumberWidget extends DrivableWidget<RandomNumberWidgetDriver, RandomNumberWidgetDriverProvider> {
///     @override
///     Widget build(BuildContext context) {
///         return Column(children: [
///             Text('${driver.randomNumber}'),
///             ElevatedButton(
///                 child: Text(driver.buttonText),
///                 onPressed: driver.updateRandomNumber,
///             ),
///         ]);
///     }
///     ...
/// }
/// ```
abstract class WidgetDriver {
  ValueNotifier<bool>? _widgetNotifier = ValueNotifier<bool>(true);

  @nonVirtual
  void notifyWidget() {
    if (_widgetNotifier != null) {
      final value = _widgetNotifier!.value;
      _widgetNotifier?.value = !value;
    }
  }

  @mustCallSuper
  void dispose() {
    _widgetNotifier?.dispose();
    _widgetNotifier = null;
  }

  void addListener(VoidCallback listener) {
    if (_widgetNotifier != null) {
      _widgetNotifier!.addListener(listener);
    }
  }

  /// Called when this driver is fully initialized.
  /// This means that the constructor has been called
  /// and the [didUpdateBuildContext] was called one time.
  ///
  /// So any `late` dependency setup you did in either the constructor or the [didUpdateBuildContext]
  /// has now been completed and your driver has access to all its initial data.
  ///
  /// The framework will call this method exactly once for each [WidgetDriver] object
  /// it creates.
  ///
  /// Override this method to perform initialization work which you want to run only one time per [WidgetDriver].
  void didInitDriver() {}

  /// If the [WidgetDriver] needs a dependency from
  /// the [BuildContext] then you can override this method.
  ///
  /// This method is called directly after the driver is created,
  /// and before the build method is called on the corresponding [DrivableWidget].
  ///
  /// You can use this to grab all the needed dependencies from the context.
  ///
  /// If you reference any [InheritedWidget] from the [BuildContext] that later changes, then
  /// the framework will call this method again to notify this driver about the change.
  ///
  /// The framework always calls [build] on your [DrivableWidget] after a dependency changes.
  /// So there is no need to call `notifyWidget` in this method since the widget's build method is called anyways.
  ///
  /// NOTE: If your driver is not referencing an [InheritedWidget]
  /// then this method is only called once directly after the driver creation.
  void didUpdateBuildContext(BuildContext context) {}
}

/// A base class for the test version of the WidgetDrivers.
///
/// When you create a test driver version of your driver,
/// then extend this `TestDriver` and implement your driver interface.
///
/// Here is an example of how you would do this:
///
/// ```dart
/// class _$TestMyAppDriver extends TestDriver implements MyAppDriver {
///     ...
/// }
/// ```
class TestDriver {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }

  void addListener(VoidCallback listener) {}

  void notifyWidget() {}

  void dispose() {}

  void didInitDriver() {}

  void didUpdateBuildContext(BuildContext context) {}
}
