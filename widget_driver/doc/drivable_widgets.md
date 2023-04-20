# DrivableWidgets

These are your new go-to-widgets!  
As the name suggests, a `DrivableWidget` is a widget that can be driven by a `Driver`.

---

## Core concepts

`DrivableWidgets` and `WidgetDrivers` are close friends. They always come in pairs. Whenever you create a `DrivableWidget`, then you will also create a `WidgetDriver`.

### The driver property

Each `DrivableWidget` has access to a property called `driver`. This is the instance of your `WidgetDriver`. When you want to grab some data from the driver and use it in your build method then all you need to do is to access the `driver`. Like this:

```dart
MyCoolWidget extends DrivableWidget<MyCoolWidgetDriver> {
    Widget build(BuildContext context) {
        return Column(children: [
            Text(driver.coolTitle),
            Text(driver.coolSubtitle),
        ]);
    }
}
```

The `driver` is the place you go to get data.  
Don't grab data directly in the widget from some other data source like a `BLoC` or `Provider` or something.

If there is data which your widget needs from some other source, then put the logic which grabs that data in the `driver`. The `driver` has access to the BuildContext and can easily resolve that data. And then the widget can access it via the `driver`.

The important part why you need to **always** go via the `driver`: When you would grab data from other sources, you cannot test your widget so easily any more!

If you always use the `driver` as a data provider in your widget, then when you test your widget, that data will be provided via the `TestDriver` and you do not need to mock it!

If you grab data from another source in your widget, then the widgetTest will crash unless you provide specific mock values for that data.

### Creating a DrivableWidget

So how do you create a `DrivableWidget`? Well that is pretty easy. Just extend `DrivableWidget` and pass in your `WidgetDriver` type as the generic type to it. Like so:

```dart
MyCoolWidget extends DrivableWidget<MyCoolWidgetDriver> {}
```

Pro tip: Since you need the type of your `WidgetDriver` as input to your `DrivableWidget`,
it is generally a good idea to create your `Driver` first.

After you defined your `DrivableWidget` then your IDE will provide you with some placeholder code which looks like this:

```dart
@override
Widget build(BuildContext context) {
    ...
}

@override
// TODO: implement driverProvider
WidgetDriverProvider<MyCoolWidgetDriver> get driverProvider => throw UnimplementedError();
```

The `build` method should be familiar to you. This is exactly the same method which you have in your normal widgets.

But the `driverProvider` property is something new. Here you need to provide an instance of a `WidgetDriverProvider` which can return an instance of your `Driver` or `TestDriver`.

Now you could implement this `WidgetDriverProvider` yourself, but if you use the code generation, then this provider type will be created for you.

The generated providers will always be prefixed with a `$` to highlight that they are generated. And the name of them will always have this format: `${name_of_your_driver}Provider`.

So for the example above, our generated provider would have this name: `$MyCoolWidgetDriverProvider`

So now we can implement the `driverProvider` property by putting this code there:

```dart
@override
WidgetDriverProvider<MyCoolWidgetDriver> get driverProvider => $MyCoolWidgetDriverProvider();
```

And then you are done! Your `DrivableWidget` is fully set up!  
Now you can go ahead and use it!
