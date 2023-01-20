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

### Generate the code

In order to generate TestDrivers and WidgetDriverProviders just run this command:

```console
flutter pub run build_runner build
```