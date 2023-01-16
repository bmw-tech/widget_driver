### Implement a `Driver` inside your project

```dart
@Driver()
class MyDriver extends WidgetDriver {
  ...

  @DriverProperty(1)
  int get value => _someService.value;

  @DriverAction()
  void doSomething() {
    ...
  }

  @DriverAction('The string')
  String giveMeSomeString() {
    return _someService.getSomeString();
  }
}
```

### Generate the code

In order to generate TestDrivers and WidgetDriverProviders just run this command:

```console
flutter pub run build_runner build
```