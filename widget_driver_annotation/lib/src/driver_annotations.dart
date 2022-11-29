/// Use this annotation on your `WidgetDriver` to generate
/// the code for the `TestDriver` and the `DriverProvider`.
class Driver {
  const Driver();
}

/// Use this annotation on your properties in the `WidgetDriver`
/// to generate the hardcoded default values for the `TestDriver`.
class DriverProperty<T> {
  final T value;
  const DriverProperty(this.value);
}

/// Use this annotation on your methods in the `WidgetDriver` to generate the
/// hardcoded default methods with correct return values for the `TestDriver`.
class DriverAction<T> {
  final T? value;
  const DriverAction([this.value]);
}
