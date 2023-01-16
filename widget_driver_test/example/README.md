## Testing WidgetDrivers

```dart
void main() {
  group('MyAppDriver:', () {
    late MockLocalization mockLocalization;

    setUp(() {
      mockLocalization = MockLocalization();
    });

    testWidgets('Shows correct app title', (WidgetTester tester) async {
      when(() => mockLocalization.appTitle).thenReturn('Some app title');

      final driverTester = await tester.getDriverTester<MyAppDriver>(
          driverBuilder: (context) => MyAppDriver(context),
          parentWidgetBuilder: (driverWidget) {
            return Provider<Localization>.value(
              value: mockLocalization,
              child: driverWidget,
            );
          });

      final driver = driverTester.driver;
      expect(driver.appTitle, equals('Some app title'));
    });
  });
}
```

To learn more about `WidgetDrivers` then please read the documentation for [widget_driver](https://github.com/bmw-tech/widget_driver) and check tests for example app there.