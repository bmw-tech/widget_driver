class MyTest {
  static final _internalInstance = MyTest();

  final map = <dynamic, dynamic>{};

  static void register<T>(T Function() builder) {
    _internalInstance.map[T] = builder;
  }

  static T? getRegistered<T>() {
    final T Function()? valueBuilder = _internalInstance.map[T];
    if (valueBuilder != null) {
      return valueBuilder();
    }
    return null;
  }
}

abstract class DependencyProvider {
  bool _didCallSetupTestValues = false;

  T get<T>(T Function() builder) {
    try {
      final T value = builder();
      return value;
    } catch (error) {
      // No dependency could be loaded using normal approach.

      if (!_didCallSetupTestValues) {
        setupTestDefaultFallbackValues();
        _didCallSetupTestValues = true;
      }

      final defaultTestValueBuilder = MyTest.getRegistered<T>();
      if (defaultTestValueBuilder != null) {
        return defaultTestValueBuilder;
      } else {
        rethrow;
      }
    }
  }

  void setupTestDefaultFallbackValues();
}

class _DependencyProvider extends DependencyProvider {
  @override
  void setupTestDefaultFallbackValues() {
    MyTest.register<MaterialColor>(() => Colors.green);
    MyTest.register<int>(() => 33333);
  }
}
