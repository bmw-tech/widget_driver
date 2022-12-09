# Drivers Without Generation

You do not need to use code generation to use `WidgetDrivers`. You can just as well create all the needed code manually. It is just a bit more manual work for you 😅

It is actually not so much code you have to create for each `driver`. But as you project grows it still adds up.

*So the recommendation would still be to use code generation.*

## What do I need to do

You just need two extra classes!  
Except for the actual `WidgetDriver` you need to create a `TestDriver` version of your `Driver`. And you need to create a `WidgetDriverProvider` which can create an instance for your `driver` and `testDriver`.

### Creating the TestDriver

The `TestDriver` is used when your widget is created during widgetTests. It cannot have any dependencies to any instance of something. It should just contain hard coded values. *(It can contain static values from some other type.)*

Your `TestDriver` needs to extend the `TestDriver` type and implement your `Driver` type. Here is an example of how to define it:

```dart
// Imagine you have a driver called `MyCoolWidgetDriver`

class MyCoolWidgetTestDriver extends TestDriver
    implements MyCoolWidgetDriver {
  @override
  String get coolName => 'A cool name';

  @override
  String get coolImageUrl => CoolImageService.testCoolImageUrl;
}
```

Notice in this example that `testCoolImageUrl` is a static property of the `CoolImageService`. Not an instance property.

So cool, now you have a `WidgetDriver` (the *MyCoolWidgetDriver*) and a `TestDriver`. Now you just need the `WidgetDriverProvider`.

This is also easy to define. You just need to extend `WidgetDriverProvider` and pass in your `WidgetDriver` as the generic type. Like this:

```dart
class MyCoolWidgetDriverProvider
    extends WidgetDriverProvider<MyCoolWidgetDriver> {
  @override
  MyCoolWidgetDriver buildDriver(BuildContext context) {
    return MyCoolWidgetDriver(context);
  }

  @override
  MyCoolWidgetDriver buildTestDriver() {
    return MyCoolWidgetTestDriver();
  }
}
```

The `WidgetDriverProvider` has two methods which you need to override. The `buildDriver` and `buildTestDriver`. In the `buildDriver` you create an instance of your real `driver` and return it.

And in the `buildTestDriver` you create and instance of your `testDriver` and return it. Makes sense right 😁

### Using your manually created code

Now you just need to go to your `DrivableWidget` and in the part where you return the `driverProvider` you just need to return an instance of your newly defined `MyCoolWidgetDriverProvider` and you are Done! Wohoo! 🥳
