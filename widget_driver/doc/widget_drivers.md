# WidgetDrivers

Let's take a deep dive into `WidgetDrivers` 🤿 😃

---

## Background

As mentioned in the [README](../), the `WidgetDriver` drives your widgets. Meaning that it provides all the dynamic data to the widget and tells it when to update.

Whenever you have a widget that has some data that changes, then you need some way to drive that logic.

Most Flutter apps probably use some common state management system like `Provider` or `BLoC`. And then in the build method of the widget they have some `BlocBuilder` or `context.watch<MyThing>()`

Or probably you even have multiple of these, so something like:

```dart
BlocBuilder<BlocA, BlocAState>(
    builder: (context, aState) {
        BlocBuilder<BlocB, BlocBState>(
            builder: (context, bState) {
                // Some widget code
            }
        )
    }
)
```

In this example these two blocs are driving the widget. If they emit new states then the widget updates. And then the widget combines these states somehow and draws the correct widget.

Now this might seem like a perfectly fine approach but it has one big issue. You are putting business logic in the widget.

This breaks the separation of concern. The widget is an UI component. Its responsibility is to specify the UI. It should not make business decisions.

Another issue with this approach is that it makes testing tougher. In your `widgetTests` you now need to test that the correct widgets are on the screen, and **also** that the two blocs behave correctly together.

And every time you test any widget which in some sub child contains these widgets, you will need to provide mock values for these specific blocs. (welcome to mocking hell 😬)

A better approach would be to have the widget only depend on one `thing`. And this `thing` only provides fixed data to the widget, meaning that the widget can just consume the data without adding more logic on top of it.  

And even better would be if this thing somehow would not need to be mocked by parent widgets when tested.

## `WidgetDriver` to the rescue 🚙

By design, the `WidgetDriver` framework gives your widget a single `driver`. It does not give you two, and it does not give you an option to create a `driver` yourself. It just provides your widgets with a `driver` property. The `driver` decides when the widget should update and which data it should get.

And it solves your testing issue also! For each `driver` the framework also creates a `testDriver`. These `testDrivers` provide hard coded default values which are used in widget tests.

So if some parent widget is using your widget, then that parent widget does not need to mock any data for your widget. It will just use its `testDriver` when running tests. Wohoo!

### Core concepts

Okay great, so now I have a `driver` which drives my widget. And I only have UI logic in my widget's build method.

But how do I get the app state into my `driver` and get the driver to update the widget.

The basic idea is that you have all your dependencies which provide state inside the `drivers`. The driver grabs the needed data out of these states and maps it to some UI friendly representation and exposes it to the widget.

And then the `drivers` listens to changes of the state and whenever it changes, it calls `notifyWidget()`.

Here is an example of a `Driver` which depends on some counter service and some localization object.

```dart
part 'counter_widget_driver.g.dart';

@GenerateTestDriver()
class CounterWidgetDriver extends WidgetDriver {
  final CounterService _counterService;
  late Locator _locator;
  StreamSubscription? _subscription;

  CounterWidgetDriver({
    CounterService? counterService,
  })  : _counterService = counterService ?? GetIt.I.get<CounterService>() {
    _subscription = _counterService.valueStream.listen((_) {
      notifyWidget();
    });
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    _locator = context.read;
  }

  @TestDriverDefaultValue('The title of the counter')
  String get counterTitle => _locator<Localization>().counterTitle;

  @TestDriverDefaultValue(1)
  int get value => _counterService.value;

  @TestDriverDefaultValue()
  void increment() {
    _counterService.increment();
  }

  @TestDriverDefaultValue()
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

There are three important concepts here.

1. The dependencies are loaded/created/resolved in the constructor of the `driver` or in the `didUpdateBuildContext` method.  
1. All the properties/methods which the driver wants to expose to the widgets needs to be annotated and given default values.
1. Whenever important data has changed in the `driver` and you want the widget to update: call `notifyWidget()`

**Let's start talking about the dependencies.**  
Any type of dependencies which your `driver` needs to be able to give your widget the correct data has to be loaded/created/resolved in the constructor of the `driver` and/or in the `didUpdateBuildContext` method and/or `didUpdateProvidedProperties` method.

You get three option here for how to resolve these dependencies. Either you can grab them out of the `BuildContext` (for example if you are using the `Provider` package). Or you can use some DI package like `get_it` and then just grab the dependencies from the DI container. Or you can pass in the dependencies to your driver using the `@driverProvidableProperty` annotation.

**Now what about those annotations?**  
They are needed for the `testDrivers` to be generated correctly. So for properties and methods with complex return types which you expose to the widget, you will need to add these annotations. Simple return types like all of [Dart's built-in types](https://dart.dev/language/built-in-types), enums, Optionals and some frequently used types in widgets like `Color` and `IconData` are already covered with default values (that you still could overwrite if you'd like).

There are two not mutually exclusive options, automatic and manual annotation. If a class is defined both ways, the manual annotation is taken for the generation.

**Option1: automatic annotation**
Here you globally specify what values should be generated for a type. This is done inside your `build.yaml`. It will load your specified values into the table where default values are taken from.

What's important is that you have to specify how they will be constructed, not something like a json version of the class. Note here, how the CustomClass is specified. Make sure though that the drivers for which the class will be generated are aware of all classes used in the constructor, otherwise you'll get a compiler error.

Add the `build.yaml` on the level of your `pubspec.yaml` in the following scheme:
```yaml
targets:
  $default:
    builders:
      widget_driver_generator:
        options:
          defaultTestValues:
            "bool": "true"
            "Color": "Colors.yellow"
            "int": "123"
            "CustomClass": "const CustomClass(name: 'name', description: 'Some desc', imageUrl: 'http://www.exampleImage.com/image',)"
            "String": "'Hello World'"
```

**Option2: Manual annotation**  
For properties and methods you add `@TestDriverDefaultValue({default_value})`.  
The `default_value` should be the default value which you want to use when this widget is being created by other widgets under test.

For properties and methods which returns futures, you have to add `@TestDriverDefaultFutureValue({default_value})`.  
This is needed so that the return value is wrapped inside a `Future`.

After you are done creating your `driver` you need to run the generator so that the `testDrivers` gets created. Read more [here](code_generation.md) about running the generators.

**Updating the widget.**  
So now you have your dependencies and they have emitted some new state and you want to update your widget. But how?!

That's easy: Just call `notifyWidget()`. This will force your widget to call its `build` method again and redraw using the latest values from your `driver`.

So for this to work, make sure that you first have all the correct data in place in your `driver` before calling `notifyWidget()`. Because as soon as you call `notifyWidget()` the widget will get updated.

### Life cycle

Your `driver` lives together with the widget it drives. As soon as that widget is inserted into the widget tree, then the `driver` gets created. If that widget gets removed from the widget tree then your `driver` gets disposed.  

NOTE: The driver is actually living inside the state of a `StatefulWidget`, and the lifecycle of the driver is the same as the lifecycle of the state of the `StatefulWidget`.

If your widget is removed from the widget tree, then the dispose method of your driver is called and you could do some clean up in your `driver`. Just override the `void dispose()` method and put your clean up code there.
