## WidgetDriver annotation usage

```dart
@GenerateTestDriver()
class CounterDriver extends WidgetDriver {
    final SomeModel model;

    CounterDriver({
        @driverProvidableProperty required this.model,
    })

    @TestDriverDefaultValue(1)
    int get value => _counterService.value;

    @TestDriverDefaultValue()
    void increment() {
        _counterService.increment();
    }

    @TestDriverDefaultValue(false)
    bool doSomething() {
        return _counterService.doSomething();
    }

    @TestDriverDefaultFutureValue(1)
    Future<int> incrementInTheFutureAndReturnValue() {
        return _counterService.incrementInTheFutureAndReturnValue();
    }
}
```

See the documentation for [widget_driver](https://github.com/bmw-tech/widget_driver/tree/master/widget_driver) to understand how these annotations work and how you can configure and use them.
