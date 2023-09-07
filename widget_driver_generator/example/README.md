### Implement a `Driver` inside your project

```dart
@GenerateTestDriver()
class MyDriver extends WidgetDriver {
  ...

  @TestDriverDefaultValue(1)
  int get value => _someService.value;

  @TestDriverDefaultValue()
  void doSomething() {
    ...
  }

  @TestDriverDefaultValue('The string')
  String giveMeSomeString() {
    return _someService.getSomeString();
  }

  @TestDriverDefaultFutureValue(123)
  Future<int> giveMeSomeIntSoon() {
    return _someService.getSomeIntSoon();
  }
}
```

### You can also pass data from the widget to the driver

```dart
class MyDriver extends WidgetDriver {
  final SomeType someNamedVariable;
  final SomeType somePositionalVariable;

  MyDriver(
    @driverProvidableProperty this.somePositionalVariable, {
    @driverProvidableProperty required this.someNamedVariable
  });

  ...
}

class MyWidget extends DriveableWidget<MyDriver> {

  @override
  Widget build(BuildContext context) {
    ...
  }

  @override
  WidgetDriverProvider<MyDriver> get driverProvider => $MyDriverProvider(
    somePositionalVariable: xyz,
    someNamedVariable: zyx,
  );
}
```

This works with named, positional and/or optional variables.

*Note: Do use this carefully. This is only intended to pass model data to the driver. (like when clicking on a list item) Try not to use this for providing repositories, to avoid coupling and ease tests.*

### Generate the code

In order to generate TestDrivers and WidgetDriverProviders just run this command:

```console
dart run build_runner build --delete-conflicting-outputs
```