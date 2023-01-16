```dart
      @DriverProperty(1)
      int get value => _counterService.value;

      @DriverAction()
      void increment() {
        _counterService.increment();
      }
```

See the documentation for [widget_driver](https://github.com/bmw-tech/widget_driver/tree/master/widget_driver) to understand how there annotations work and how you can configure and use them.