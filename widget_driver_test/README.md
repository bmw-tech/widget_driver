# WidgetDriver test

[![pub package](https://img.shields.io/pub/v/widget_driver_test.svg)](https://pub.dev/packages/widget_driver_test)
[![check-code-quality](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml/badge.svg?branch=master)](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

A package that makes testing `WidgetDrivers` and `DrivableWidgets` easy.  
Built to work with mocktail for easy mocking.

To learn more about `WidgetDrivers` then please read the documentation for [widget_driver](../widget_driver).

For inspiration on how to use this package to test your widgets and drivers, then please see the tests in the example app [here](../widget_driver/example/test).

---

## Testing DrivableWidgets

### Create a mock driver

When you are testing your drivable widgets, then you probably want to mock the driver which drives them.

To make it easier to mock the drivers, we have created a base mock class which you can extend. This gives you functionality from [mocktail](https://pub.dev/packages/mocktail) that you can use on your mock instance.

```dart
import 'package:mocktail/mocktail.dart';

...

class MockMyWidgetDriver extends MockDriver implements MyWidgetDriver {}

...

mockMyWidgetDriver = MockMyWidgetDriver();
when(() => mockMyWidgetDriver.title).thenReturn('Hey this is a mocked title');
```

### Using a mock driver in DrivableWidget

When you have created your mocked driver, then you also want to use it in your widget.

To make it easy to provide a mocked driver into a drivable widget, we have created a helper class which can provide this.

Create an instance of `MockDriverProvider` and pass it the mocked driver as value and the drivable widget as a child.

```dart
final myWidget = MockDriverProvider<MyWidgetDriver>(
    value: mockMyWidgetDriver,
    child: MyWidget(),
);

await tester.pumpWidget(myWidget);
// Do your widget testing now
```

## Testing WidgetDrivers

To test your `Drivers` you need your tests to use the `testWidgets` test function (just like you do when you test widgets)

```dart
void main() {
    testWidgets('Some driver test', (WidgetTester tester) async {
        // Put your driver test code here
    }
}
```

### Create a driver

To create your driver you will need a helper function.  
This is because the `Driver` needs a build context as a parameter to its constructor. To help you with this we have created a helper function on the `WidgetTester`.

This is how you create your `Driver`:

```dart
testWidgets('Some driver test', (WidgetTester tester) async {
    final driverTester = await tester.getDriverTester<MyWidgetDriver>(
          driverBuilder: (context) => MyWidgetDriver(context, theService: mockTheService),
          parentWidgetBuilder: (driverWidget) {
            return MultiProvider(
              providers: [
                Provider<SomeService>.value(value: mockSomeService),
                Provider<AnotherService>.value(value: mockAnotherService),
              ],
              child: driverWidget,
            );
          });
}
```

As you can see, you create the `Driver` by calling `tester.getDriverTester(...)`.  
This will return you a `DriverTester`. You use this driverTester to test your driver.

In this example, we are creating a driver called `MyWidgetDriver`. It has some internal dependencies which it resolves from the `BuildContext` (`SomeService` and `AnotherService`) and one dependency which gets passed in as a parameter to the constructor.

In the `driverBuilder` you pass a builder which creates your `Driver`. There you can provide all mocked dependencies which you pass in via the constructor. E.g. the `theService`.

The other two dependencies needs to be in the build context when the driver gets created. So we need to put the mocked versions of these dependencies in a widget above the `Driver`. This is done via the optional `parentWidgetBuilder` parameter to the `getDriverTester` method.

There you can pass in a widget which then takes a `driverWidget` as a child. This `driverWidget` is the widget which contains the `Driver`.

In our example we pass in our mocked services by using the Provider package.

### Testing a Driver

Once you have access to the `DriverTester`, then you can use it to test the `Driver`.  
The `driverTester` has a property called `driver`. This gives you access to an instance of your `Driver`. This is the `driver` that you will use during your tests.

```dart
testWidgets('Some driver test', (WidgetTester tester) async {
    final driverTester = await tester.getDriverTester<MyWidgetDriver>(...)

    final driver = driverTester.driver;
    expect(driver.buttonText, equals('The expected text'));
```

If your driver updates the widget when some of its dependencies change state, then you easily test this also by awaiting calls to the `notifyWidget()`.

```dart
testWidgets('When isLoggedInStream emits then notifyWidgets is called', (WidgetTester tester) async {
    final driverTester = await tester.getDriverTester<LogInOutButtonDriver>(...)

    isLoggedInStreamController.add(true);
    isLoggedInStreamController.add(false);

    // Wait for the driver to receive 2 notifyWidget calls.
    await driverTester.waitForNotifyWidget(numberOfCalls: 2, requireExactNumberOfCalls: true);
    // Verify no more calls to `notifyWidget`
    await driverTester.verifyNoMoreCallsToNotifyWidget();
```

Here we have a driver which has an internal dependency to a some auth service. Whenever the auth service changes the logged in state, then the driver will call the `notifyWidgets()` an update the widget.

We want to verify that the driver really calls `notifyWidgets()` and to do this we can use a helper function on the driverTester.

There are two functions which helps us here.  
First the `waitForNotifyWidget` will wait until the specified number of calls to `notifyWidgets()` have been reached. If you never get enough calls, then the `waitForNotifyWidget` will timeout and your test will fail. You can pass in the timeout duration as a parameter to the method. It defaults to 1 seconds.

Second, you can use the `verifyNoMoreCallsToNotifyWidget` to wait and check that no more calls are made to the `notifyWidgets()`. You can control how long the method will wait and check for call by passing in a timeout duration to the method. The default value is 1 second.
