/// Use this annotation on your `WidgetDriver` to generate
/// the code for the `TestDriver` and the `DriverProvider`.
class GenerateTestDriver {
  const GenerateTestDriver();
}

/// Use this annotation on properties/methods in your `Driver` to generate
/// the hardcoded default test values which will be used by the `TestDriver`.
/// Your `DrivableWidget` will then use these values from the `TestDriver`
/// when it is created during testing.
///
/// ### Here is an example of how to use these:
///
/// ```dart
/// @GenerateTestDriver()
/// class RandomNumberWidgetDriver extends WidgetDriver {
///     RandomNumberService _randomNumberService = ...;
///     Localization _localization = ...;
///
///     @TestDriverDefaultValue(123)
///     int get randomNumber => _randomNumberService.theRandomNumber;
///
///     @TestDriverDefaultValue('Get new random number')
///     String get buttonText => _localization.getRandomNumberButtonText;
///
///     @TestDriverDefaultValue()
///     void updateRandomNumber() {
///         ...
///     }
/// }
/// ```
///
/// This will generate the following `TestDriver`
/// ```dart
/// class _$RandomNumberWidgetDriver extends TestDriver implements CoffeeLibraryPageDriver {
///     @override
///     int get randomNumber => 123;
///
///     @override
///     String get buttonText => 'Get new random number';
///
///     @override
///     void updateRandomNumber() {}
/// }
/// ```
class TestDriverDefaultValue<T> {
  final T? value;
  const TestDriverDefaultValue([this.value]);
}

/// Use this annotation on properties/methods which return `Futures` in your
/// `Driver` to generate the hardcoded default test values which will be used
/// by the `TestDriver`. Your `DrivableWidget` will then use these values from
/// the `TestDriver` when it is created during testing.
///
/// ### Here is an example of how to use these:
///
/// ```dart
/// @GenerateTestDriver()
/// class RandomNumberWidgetDriver extends WidgetDriver {
///     RandomNumberService _randomNumberService = ...;
///
///     @TestDriverDefaultFutureValue(123)
///     Future<int> get randomNumber => _randomNumberService.theRandomNumberFuture;
///
///     @TestDriverDefaultFutureValue(false)
///     Future<bool> updateRandomNumber() {
///         ...
///     }
/// }
/// ```
///
/// This will generate the following `TestDriver`
/// ```dart
/// class _$RandomNumberWidgetDriver extends TestDriver implements CoffeeLibraryPageDriver {
///     @override
///     Future<int> get randomNumber => Future.value(123);
///
///     @override
///     Future<bool> updateRandomNumber() {
///         return Future.value(false);
///     }
/// }
/// ```
class TestDriverDefaultFutureValue<T> {
  final T? value;
  const TestDriverDefaultFutureValue([this.value]);
}
