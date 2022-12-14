# WidgetDriver

[![pub package](https://img.shields.io/pub/v/widget_driver.svg)](https://pub.dev/packages/widget_driver)
[![check-code-quality](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml/badge.svg?branch=master)](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

A Flutter presentation layer framework, which will clean up your  
widget code and make your widgets testable without a need for thousands of mock objects.  
Let's go driving! 🚙💨

---

## Features

In Flutter everything is a Widget. And that is great!  
But maybe you should not put all of your code directly in the widgets.  

Doing that will:

- give you a headache when you try to write unit tests
- make it tougher to reuse your code
- clutter the declarative UI part of Flutter

`WidgetDriver` to the rescue! `WidgetDriver` gives you a [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) style presentation layer framework.  
It effectively guides you into moving all of the business logic parts of your code out from widgets and into something called `WidgetDrivers`.

### Core features of WidgetDriver

-  Clear separation of concern.  
Business logic goes in the `Driver` and only the view logic  goes in the `Widget`
- Better testability of your `Widgets`.  
When you use `WidgetDriver` then you can **test your `Widgets` in isolation**!  
You do not need to mock hundreds of child dependencies!


### Testing benefits

We have all been there. We write `widgetTests` and over time we end up with 90% of our testing code being about creating mock objects. Why is that?  

Well since widgets tend to contain other child widgets and these widget contains yet more widgets. All these widgets have their own set of dependencies which needs to be resolved when they get created.

So when you want to write a simple `widgetTest` for a widget, then you end up needing to provide mock data for all the dependencies of all your children. 😱

`WidgetDriver` to the rescue again! `WidgetDriver` uses a special `TestDriver` when you are running tests. These `TestDrivers` provide predefined default values to all child widgets so that you do not need to provide any dependencies! 🥳  

This mean you can finally test your widgets in isolation!  
Just focus on the current widget under test, and forget about all other child widgets and their dependencies!

---

## Usage

Let's get started and create our first `WidgetDriver`!

### 1: counter_widget_driver.dart

```dart
part 'counter_widget_driver.g.dart';

@Driver()
class CounterWidgetDriver extends WidgetDriver {
  final CounterService _counterService;
  final Localization _localization;
  StreamSubscription? _subscription;

  CounterWidgetDriver(
    BuildContext context, {
    CounterService? counterService,
  })  : _counterService = counterService ?? GetIt.I.get<CounterService>(),
        _localization = context.read<Localization>(),
        super(context) {

    _subscription = _counterService.valueStream.listen((_) {
      notifyWidget();
    });

  }

  @DriverProperty('The title of the counter')
  String get counterTitle => _localization.counterTitle;

  @DriverProperty(1)
  int get value => _counterService.value;

  @DriverAction()
  void increment() {
    _counterService.increment();
  }

  @DriverAction()
  void decrement() {
    _counterService.decrement();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
```

Okay wait, what was all that?! That looks very complicated!

Well, not really. Let's dive into what happens:

1. First we just define a driver which extend the `WidgetDriver`.  
  The "`part '...'`" definition and the `@Driver()` annotation above it is needed later for the code generation to work.
    ```dart
    part 'counter_widget_driver.g.dart';

    @Driver()
    class CounterWidgetDriver extends WidgetDriver {
    ```

    And thats all you need to conform to the `WidgetDriver` interface. The rest of the code in a `WidgetDriver` depends on your use case.

1. Next, we define the dependencies which the driver needs. In our case we need access to some service which can keep track of the count and we need some localizations.  
  In the constructor of the driver we have the option to resolve these dependencies either from the `BuildContext` (for example using something like the [Provider package](https://pub.dev/packages/provider)), or we can load them using a DI package such as [get_it](https://pub.dev/packages/get_it).
    ```dart
    final CounterService _counterService;
    final Localization _localization;
    StreamSubscription? _subscription;

    CounterWidgetDriver(
      BuildContext context, {
      CounterService? counterService,
    })  : _counterService = counterService ?? GetIt.I.get<CounterService>(),
        _localization = context.read<Localization>(),
        super(context) {
      ...
    }
    ```
  
1. Now we need to add some logic where the `Driver` listens to changes from the `CounterService` and when a changes happens, then it will notify the widget that it needs to update. You do this by calling the `notifyWidget()` method in the driver. 
As soon as your `Driver` has new data to display, then you want to call the `notifyWidget()`.

    ```dart
    _subscription = _counterService.valueStream.listen((_) {
      notifyWidget();
    });
    ```

1. Finally, we define the public API of the driver. The widget will use these to grab data for its views.  

    The annotations are used by the `TestDriver` to provide default values during testing.  

    For each public property you add the `@DriverProperty({default value})`.  
    As a parameter to this annotation you provide the default value which will be used in testing when other widgets create this widget.  

    And for your methods you add the `@DriverAction()`.
      ```dart
      @DriverProperty(1)
      int get value => _counterService.value;

      @DriverAction()
      void increment() {
        _counterService.increment();
      }
      ```

      As mentioned, these annotations are used by the `TestDriver`, and you have to provide them! The values provided there are only used in testing. Never in any production code. Because in production you use the real business logic.

      But in your `widgetTests` these values are used when your widget is rendered as a child-widget. This helps you to test widgets in isolation, without caring about which dependencies all your child widgets need. 

      For a more in-depth documentation about `TestDrivers` read [here](doc/testing.md).

Thats it! Wohoo! 🥳  
Now we can continue to the next step!

### 2: Code generation

Now it is time to generate some code so that we get our `TestDriver` and `WidgetDriverProvider` set up for us.  
*If you prefer to do this the old fashioned way without code generation, then that is also possible. 
Read more about that [here](doc/drivers_without_generation.md)*

At the root of your flutter project, run this command:

```bash
flutter pub run build_runner build
```

When the build runner completes then we are ready to start building our widget

### 3: counter_widget.dart

```dart
class CounterWidget extends DrivableWidget<CounterWidgetDriver> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(driver.counterTitle),
          const SizedBox(width: 5),
          Text('${driver.value}'),
        ],
      ),
      ElevatedButton(
        onPressed: driver.increment,
        child: const Text('increment'),
      ),
      ElevatedButton(
        onPressed: driver.decrement,
        child: const Text('decrement'),
      ),
    ]);
  }

  @override
  WidgetDriverProvider<CounterWidgetDriver> get driverProvider => $CounterWidgetDriverProvider();
}
```

And voila, we are done!  
Now check out that widget code! Isn't that clean.  
Just focused on UI. No StreamBuilders or BuildContext being watched.  
And **no** dependency being created or resolved!

Let's go over what happens:

1. First we name our widget `CounterWidget` and then we need to make it `drivable`! We do this by making it extend `DrivableWidget`. Pass in the name of your `Driver` as a generic type to the `DrivableWidget`.
    
    ```dart
    class CounterWidget extends DrivableWidget<CounterWidgetDriver> {
    ```

1. Now your `IDE` will complain and say that you are `Missing concrete implementation ...`  
    To fix this, tap the `Create 2 missing overrides`-button and voila! You get some placeholder code which looks like this:
    ```dart
    @override
    Widget build(BuildContext context) {
      ...
    }

    @override
    // TODO: implement driverProvider
    WidgetDriverProvider<CounterWidgetDriver> get driverProvider => throw UnimplementedError();
    ```
    The build method is nothing new. There you just put your widget creation code!  
    And the `driverProvider` is the thing which knows how to create your driver. Now what do you put here?  
    No worries, we generated a `DriverProvider` for you 🤩
    Just replace that line with this:
    ```dart
    @override
    WidgetDriverProvider<CounterWidgetDriver> get driverProvider => $CounterWidgetDriverProvider();
    ```

    For each `WidgetDriver` you get a generated `WidgetDriverProvider`. They are all prefixed with `$` to indicate that they are generated. So just grab the provider which belongs to your driver and create an instance of it here.

1. And that is all you need to do!  

    Now your widget will automatically have access to a property called `driver`. This driver is the very same `WidgetDriver` which we defined earlier. So now you can access all the data from it and assign it to your widgets. For example you can say this:
    ```dart
    Text(driver.counterTitle),
    ```

### 4: Handling updates to data in WidgetDriver

But what if my data changes? How do I update the widget? Do I need a `builder`? Or a `context.watch`?

**NO!** The WidgetDriver frameworks handles this for you!  
The driver decides when the widget needs to update. So inside your driver code, whenever something important changed and you want to update the widget, then you just call the `notifyWidget()`.

This will automatically make sure that your widget get reloaded and it can consume the latest values from your driver.

### Demo

Here is a demo of how the final product looks like

<p>
  <img src="doc/resources/counter_widget_demo.gif?raw=true"
  height="400"/>
</p>

## Guidelines

`WidgetDriver` gives you two big benefits.

- Move business logic out of the widget. Clean up the UI code.
- Test widgets in isolation without the of mocks mocks mocks.

But you only gain these benefits if you follow these guidelines.

### Guideline One - Architecture 🏗️

Move out Business Logic out from the Widgets!  
That logic should now instead go inside the `WidgetDriver`.

It is **NOT** the job of a Widget to create and combine dependencies!  
The `Driver` is the place where you want to create/resolve dependencies and combine them.  
The `Driver` has access to the `BuildContext` which was used to create your widget, so you can resolve any needed dependency directly out from that context if you want.

The widget is **ONLY** interested in creating UI and reacting to interactions from the user.

`WidgetDriver` gives you all the tools you need to stop putting business logic in the widget. 

### Guideline Two - Testing 🔬

Thanks to the `TestDrivers` which get auto-created for you when running widget tests, you do not have to mock your dependencies in the tests.  

When you run tests, then the real `driver` is not created. Instead the `testDriver` gets created and it just provides hard coded default values.

The only thing you need to do when testing a widget is to mock the `driver` for that specific widget.
You just need to mock the `driver` used by the widget which is currently under test and that is it! No other mocks are needed.

But you only get this benefit if you move the business logic out of the widget.  

When you keep business logic in your widgets, then the parent widgets will need to provide mock values for all those child widgets and you end up in mock-mock-mock-world

So please follow guideline two -> Put your business logic in the `Driver`, not in the `Widget`!

More about testing and the benefits are described [here](doc/testing.md)

## Installation

Update your `pubspec.yaml` with this:

```yaml
dependencies:
  widget_driver: <latest_version>

...

dev_dependencies:
  build_runner: <latest_version>
  widget_driver_generator: <latest_version>
```

## Examples

Please see this [example app](example) for inspiration on how to use `WidgetDrivers` in your app.  
The app also contains examples on how you can test your `DrivableWidgets` and their `Drivers`.

## WidgetDriver and State Management

`WidgetDriver` is **NOT** a state management framework/library.  
It is a presentation layer framework. It gives structure and organization to the code which drives your widgets.

But the application state should not be stored in the `Driver`! It is not the owner of state. Think of `Drivers` as `ViewModels`. They take in state and transform it and then provide a tailor made version of it to the widget. E.g. the driver might get in a `Date` object which it then transforms into a string representation and gives this string to the widget.

So the `Drivers` will need to access state somehow. [Here](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) is a list of recommended state management approaches. **BUT** just make sure to use these state management systems in the `Driver`.

For e.g. if you choose to use [Provider](https://pub.dev/packages/provider), then don't use your `Provider` in the widgets. So don't use `context.watch<T>()`. Instead you then want to use the `Providers` in your `Driver`. See the [example app](example/) for inspiration on how to do this.

## Documentation

- [WidgetDrivers](doc/widget_drivers.md)
- [DrivableWidgets](doc/drivable_widgets.md)
- [Testing](doc/testing.md)
- [Code generation](doc/code_generation.md)
- [Using WidgetDrivers without code generation](doc/drivers_without_generation.md)
- [Contribution guide](../CONTRIBUTING.md)
