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

class _DriverProvidableModel {
  const _DriverProvidableModel();
}

/// Use this annotation on constructor params, which should be able to be passed from the `DrivableWidget` to the `
/// Driver`.
/// This is intended for model data and not repositories.
///
/// ### Here is an example on how to use the Annotation
///
/// ```dart
/// @GenerateTestDriver()
/// class CoffeeDetailPageDriver extends WidgetDriver {
///   final Coffee _coffee;
///
///   CoffeeDetailPageDriver(
///     BuildContext context, {
///     @driverProvidableModel required Coffee coffee,
///   })  : _coffee = coffee,
///         super(context);
///
///   // ...
/// }
/// ```
///
/// This will generate the following `DriverProvider`
/// ```dart
/// class $CoffeeDetailPageDriverProvider extends WidgetDriverProvider<CoffeeDetailPageDriver> {
///   final Coffee _coffee;
///
///   $CoffeeDetailPageDriverProvider({
///     required Coffee coffee,
///   }) : _coffee = coffee;
///
///   @override
///   CoffeeDetailPageDriver buildDriver(BuildContext context) {
///     return CoffeeDetailPageDriver(
///       context,
///       coffee: _coffee,
///     );
///   }
///
///   @override
///   CoffeeDetailPageDriver buildTestDriver() {
///     return _$TestCoffeeDetailPageDriver();
///   }
/// }
/// ```
///
/// And can be used in the widget like this.
/// ```dart
/// class CoffeeDetailPage extends DrivableWidget<CoffeeDetailPageDriver> {
///   final Coffee coffee;
///
///   CoffeeDetailPage({Key? key, required this.coffee}) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       // ...
///     );
///   }
///
///   @override
///   WidgetDriverProvider<CoffeeDetailPageDriver> get driverProvider => $CoffeeDetailPageDriverProvider(coffee: coffee);
/// }
/// ```
const driverProvidableModel = _DriverProvidableModel();
