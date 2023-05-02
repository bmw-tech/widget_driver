# WidgetDriver quick guide

## Minium steps needed to get started with WidgetDriver

Following these steps will give you this:
<div align="left">
  <img src="https://github.com/bmw-tech/widget_driver/blob/master/widget_driver/doc/resources/widget_driver_intro_example.gif?raw=true" style="max-width: 300px">
</div>

### 1. Get dependencies

Update your `pubspec.yaml` with this:

```yaml
dependencies:
  widget_driver: <latest_version>

...

dev_dependencies:
  build_runner: <latest_version>
  widget_driver_generator: <latest_version>
```

And run `flutter pub get`

### 2. Create your Driver

In this example we are creating a driver called `MyFirstDrivableWidgetDriver` in a file called `my_first_drivable_widget_driver.dart`.

```dart
import 'package:widget_driver/widget_driver.dart';

part 'my_first_drivable_widget_driver.g.dart';

@GenerateTestDriver()
class MyFirstDrivableWidgetDriver extends WidgetDriver {
  int _count = 0;

  @TestDriverDefaultValue('The app bar title')
  String get appBarTitle => 'Intro to WidgetDriver';

  @TestDriverDefaultValue('Counter:')
  String get counterTitle => 'Counter:';

  @TestDriverDefaultValue('0')
  String get counterValue => '$_count';

  @TestDriverDefaultValue()
  void increaseCounterAction() {
    _count += 1;
    notifyWidget();
  }

  @TestDriverDefaultValue()
  void resetCounterAction() {
    _count = 0;
    notifyWidget();
  }
}
```

### 2. Create your Drivable Widget

Run the WidgetDriver code generator.
At the root of your flutter project, run this command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Create your Drivable Widget

Now you are ready to create your DrivableWidget.
Just make it extend `DrivableWidget<MyFirstDrivableWidgetDriver>`.

Now your IDE will complain and auto generate the build method and a `driverProvider` getter. For the `driverProvider` getter you return an instance of the newly generated `$MyFirstDrivableWidgetDriverProvider` class.

Now you are done! :D  
In your builder method you now have access to the `driver`.

```dart
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'my_first_drivable_widget_driver.dart';

class MyFirstDrivableWidget extends DrivableWidget<MyFirstDrivableWidgetDriver> {
  MyFirstDrivableWidget({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: Text(driver.appBarTitle)), // <-- The title comes from the driver
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: driver.increaseCounterAction, // <-- Action is forwarded to the driver
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: driver.resetCounterAction,
            child: const Icon(Icons.restore),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          // Texts come from the driver
          Text(driver.counterTitle, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(driver.counterValue, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<MyFirstDrivableWidgetDriver> get driverProvider => $MyFirstDrivableWidgetDriverProvider();
}
```

