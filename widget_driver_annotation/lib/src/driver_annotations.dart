class Driver {
  const Driver();
}

class DriverProperty<T> {
  final T value;
  const DriverProperty(this.value);
}

class DriverAction<T> {
  final T? value;
  const DriverAction([this.value]);
}
