# WidgetDriver

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

TL;DR: The `WidgetDrivers` will drive your widgets and provide them with all the data they need.

### Testing benefits

We have all been there. We write `widgetTests` and over time we end up with 90% of our testing code being about creating mock objects. Why is that?  

Well since widgets tend to contain other child widgets and these widget contains yet more widgets. All these widgets have their own set of dependencies which needs to be resolved when they get created.

So when you want to write a simple `widgetTest` for a widget, then you end up needing to provide mock data for all the dependencies of all your children. 😱

`WidgetDriver` to the rescue again! `WidgetDriver` will use a special `TestDriver` when you are running tests. These `TestDrivers` provide predefined default values to all child widgets so that you do not need to provide any dependencies! 🥳

---

## Usage

Let's get started and create our first `WidgetDriver`.  

### counter_widget_driver.dart

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

Okay wait, what was all that? That looks very complicated!

Well, not really. Let's dive into what happens:

1. First we just define a driver which extend the `WidgetDriver`.  
  The `part '...'` definition and the `@Driver()` annotation above it is needed later for the code generation to work.
    ```dart
    part 'counter_widget_driver.g.dart';

    @Driver()
    class CounterWidgetDriver extends WidgetDriver {
    ```

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
      _subscription = _counterService.valueStream.listen((_) {
        notifyWidget();
      });
    }
    ```

  1. Finally, we define the public API of the driver. The widget will use these to populate its views with real data.  
    The annotations are used in the code generation later.  
    For each public property you add the `@DriverProperty({default value})`. As a parameter to this annotation you provide the default value which will be used in testing when other widgets create this widget.
    And for your methods you add the `@DriverAction({default return value})`. Same here. The values you specify here are used when this widget is created during testing.
      ```dart
      @DriverProperty(1)
      int get value => _counterService.value;

      @DriverAction()
      void increment() {
        _counterService.increment();
      }
      ```

Thats it! Now we can continue to the next step!

### Code generation

Now it is time to generate some code so that we get our `TestDriver` set up for us.  
*If you prefer to do this the old fashioned way without code generation, then that is also possible.  
There will soon be a link here to the documentation which describes how to do this.*

At the root of your flutter project, run this command:

```bash
flutter pub run build_runner build
```

When the build runner completes then we are ready to start building our widget

### counter_widget.dart

```dart
class CounterWidget extends $CounterDrivableWidget {
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
  $CounterWidgetDriverProvider get driverProvider => $CounterWidgetDriverProvider();
}
```

And voila, we are done!  
Now check out that widget code! Isn't that clean.  
Just focused on UI. No StreamBuilders or BuildContext being watched.

Let's go over what happens:

1. First we name our widget `CounterWidget` and then we need to make it `drivable`!  
    We do this by making it extend the newly generated type called `$CounterDrivableWidget`. (For each driver you will get a type like this!)
    The `$` sign infront of the name is there to highlight that this is a generated type.
    ```dart
    class CounterWidget extends $CounterDrivableWidget {
    ```

1. Now your `IDE` will complain and say that you are `Missing concrete implementation ...`  
    To fix this, tap the `Create 2 missing overrides` and voila! You get some placeholder code which looks like this:
    ```dart
    @override
    Widget build(BuildContext context) {
      ...
    }

    @override
    // TODO: implement driverProvider
    $CounterWidgetDriverProvider get driverProvider => throw UnimplementedError();
    ```
    The build method is nothing new. There you just put your widgets!  
    And the `driverProvider` is the thing which knows how to create your driver. Where does this come from?  
    No worries, we generated that for you 🤩
    Just replace that line with this:
    ```dart
    @override
    $CounterWidgetDriverProvider get driverProvider => $CounterWidgetDriverProvider();
    ```

1. And that is all you need to do! Now your widget will have access to a property called `driver`. This driver is the very same driver which we defined earlier. So now you can access all the need data and assign it to your widgets. For example you can say this:
    ```dart
    Text(driver.counterTitle),
    ```


But what if my data changes? How do I update the widget? Do I need a `builder`? Or a `context.watch`?

**NO!** The WidgetDriver frameworks handles this for you!  
The driver decides when the widget needs to update. So inside your driver code, whenever something important changed and you want to update the widget, then you just call the `notifyWidget()`.

This will automatically make sure that your widget get reloaded and it can consume the latest values from your driver.

### Demo

Here is a demo of how the final product looks like

<p>
  <img src="doc/resources/counter_widget_demo.gif?raw=true"
    alt="An animated image of the iOS in-app purchase UI" height="400"/>
</p>

## `WidgetDriver` benefits

`WidgetDriver` gives you two big benefits

### One

You move out Business Logic out from the Widgets!

It is **NOT** the job of a Widget to create and combine dependencies!  
The `Driver` is the place where you want to create/resolve dependencies and combine them.  
The `Driver` has access to the `BuildContext` which was used to create your widget, so you can resolve any needed dependency directly out from that context if you want.

The widget is **ONLY** interested in creating UI and reacting to interactions from the user.

### Two

Thanks to the `TestDrivers` which get auto-created for you when running unit tests,  
you do not have to mock all of your dependencies in the tests.

You just need to mock the `driver` used by the widget which is currently under test and that is it!

More about testing and the benefits are described [here](#Demo)

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

Please see this [example app](example) for inspiration on how to use `WidgetDriver` in your app.  
The app also contains examples on how you can test your `DrivableWidgets` and their `Drivers`.

## Documentation

(This part is still under construction. Clickable links will come soon)

- WidgetDrivers
- DrivableWidgets
- Testing
- Code generation
- Using WidgetDrivers without code generation
- Contribution guide
