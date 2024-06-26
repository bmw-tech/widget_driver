# WidgetDriver quick guide

## Minimum steps needed to get started with WidgetDriver

If you follow these steps then you will get this:
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

Run: `flutter pub get`

### 2. Create your Driver

In this example we are creating a driver called `MyFirstDrivableWidgetDriver` in a file called `my_first_drivable_widget_driver.dart`.

```dart
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

part 'my_first_drivable_widget_driver.g.dart';

@GenerateTestDriver()
class MyFirstDrivableWidgetDriver extends WidgetDriver {
  int _count = 0;

  // The next line is not necessary, since it's a String but if you want to customize the generated output, you can add this.
  @TestDriverDefaultValue('The app bar title')
  String get appBarTitle => 'Intro to WidgetDriver';

  String get counterTitle => 'Counter:';

  String get counterValue => '$_count';

  IconData get increaseActionIcon => Icons.add;

  IconData get resetActionIcon => Icons.restore;

  void increaseCounterAction() {
    _count += 1;
    notifyWidget();
  }

  void resetCounterAction() {
    _count = 0;
    notifyWidget();
  }
}
```

### 3. Run the generator

Run the WidgetDriver code generator.  
At the root of your flutter project, run this command:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Create your Drivable Widget

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(driver.appBarTitle)), // <-- The title comes from the driver
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: driver.increaseCounterAction, // <-- Action is forwarded to the driver
            child: Icon(driver.increaseActionIcon),  // <-- Icon comes from the driver
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: driver.resetCounterAction,
            child: Icon(driver.resetActionIcon),
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
