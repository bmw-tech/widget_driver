import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

/// This is a Driver used by the unit tests.
/// Since `WidgetDriver` is just an abstract interface we
/// need some concrete instance which we can use in our tests.
/// This is the driver which is driving the `TestContainerDrivableWidget`.
class TestContainerDriver extends WidgetDriver {
  int someData;

  TestContainerDriver(
    BuildContext context, {
    int? newSomeData,
  })  : someData = newSomeData ?? -1,
        super(context);

  String get aTestText => 'A test text';

  bool didCallTestMethod = false;
  void aTestMethod() {
    didCallTestMethod = true;
    notifyWidget();
  }

  int numberOfCallsToUpdateDriverProvidedProperties = 0;

  void updateDriverProvidedProperties({required int newSomeData}) {
    someData = newSomeData;
    numberOfCallsToUpdateDriverProvidedProperties++;
  }
}

/// This is the TestDriver version of the `TestContainerDriver`.
/// This driver will be created by the `TestContainerDrivableWidget` when
/// the we are running in a test environment.
class TestContainerTestDriver extends TestDriver implements TestContainerDriver {
  @override
  int someData = -1;

  @override
  String get aTestText => 'TestDriver test text';

  @override
  bool didCallTestMethod = false;

  @override
  void aTestMethod() {}
}

/// This is the provider used by `TestContainerDrivableWidget`
/// to create the correct drivers for it.
class TestContainerDriverProvider extends WidgetDriverProvider<TestContainerDriver> {
  int driverBuiltCount = 0;
  final int someData;

  TestContainerDriverProvider({
    int? newSomeData,
  }) : someData = newSomeData ?? -1;

  @override
  TestContainerDriver buildDriver(BuildContext context) {
    driverBuiltCount++;
    return TestContainerDriver(context, newSomeData: someData);
  }

  @override
  TestContainerDriver buildTestDriver() {
    return TestContainerTestDriver();
  }

  @override
  void updateDriverProvidedProperties(TestContainerDriver driver) {
    driver.updateDriverProvidedProperties(newSomeData: someData);
  }
}

/// This is a DrivableWidget used by the unit tests.
/// Since `DrivableWidget` is just an abstract interface we
/// need some concrete instance which we can use in our tests.
/// The driver which drives this widget is a `TestContainerDriver`.
class TestContainerDrivableWidget extends DrivableWidget<TestContainerDriver> {
  final TestContainerDriverProvider? provider;
  final int someData;
  final void Function(TestContainerDriver driver)? driverCallback;

  TestContainerDrivableWidget({
    Key? key,
    RuntimeEnvironmentInfo? environmentInfo,
    this.provider,
    int? newSomeData,
    this.driverCallback,
  })  : someData = newSomeData ?? -1,
        super(key: key, environmentInfo: environmentInfo);

  @override
  Widget build(BuildContext context) {
    driverCallback?.call(driver);
    return Column(
      children: [
        Text(driver.aTestText),
        Text('didCallTestMethod: ${driver.didCallTestMethod}'),
        Text('justSomeData: ${driver.someData}'),
      ],
    );
  }

  @override
  WidgetDriverProvider<TestContainerDriver> get driverProvider =>
      provider ?? TestContainerDriverProvider(newSomeData: someData);
}

class WrappedTestContainer extends StatefulWidget {
  final RuntimeEnvironmentInfo environmentInfo;
  final Function(TestContainerDriver) driverCallback;

  const WrappedTestContainer({
    Key? key,
    required this.environmentInfo,
    required this.driverCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WrappedTestContainerState();
}

class WrappedTestContainerState extends State<WrappedTestContainer> {
  int someData = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MaterialButton(
        key: const Key('wrapped_test_container_button'),
        onPressed: () => setState(() {
          someData++;
        }),
        child: TestContainerDrivableWidget(
          newSomeData: someData,
          environmentInfo: widget.environmentInfo,
          driverCallback: widget.driverCallback,
        ),
      ),
    );
  }
}

class ProviderWidget extends StatefulWidget {
  final Widget child;

  const ProviderWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<ProviderWidget> createState() => _ProviderWidgetState();
}

class _ProviderWidgetState extends State<ProviderWidget> {
  int providedValue = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider.value(
        value: providedValue,
        child: MaterialButton(
          key: const Key('provider_widget_action_button'),
          onPressed: updatedProvidedValue,
          child: widget.child,
        ),
      ),
    );
  }

  void updatedProvidedValue() {
    setState(() {
      providedValue++;
    });
  }
}

class WatchDriver extends WidgetDriver {
  final int _provided;

  WatchDriver(BuildContext context)
      : _provided = context.watch<int>(),
        super(context);

  int get provided => _provided;
}

class WatchDriverProvider extends WidgetDriverProvider<WatchDriver> {
  int driverBuiltCount = 0;
  @override
  WatchDriver buildDriver(BuildContext context) {
    driverBuiltCount++;
    return WatchDriver(context);
  }

  @override
  WatchDriver buildTestDriver() {
    throw UnimplementedError();
  }
}

class WatchWidget extends DrivableWidget<WatchDriver> {
  final WatchDriverProvider? provider;

  WatchWidget({
    Key? key,
    RuntimeEnvironmentInfo? environmentInfo,
    this.provider,
  }) : super(key: key, environmentInfo: environmentInfo);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  WidgetDriverProvider<WatchDriver> get driverProvider => provider ?? WatchDriverProvider();
}

class ReadDriver extends WidgetDriver {
  final int _provided;

  ReadDriver(BuildContext context)
      : _provided = context.read<int>(),
        super(context);

  int get provided => _provided;
}

class ReadDriverProvider extends WidgetDriverProvider<ReadDriver> {
  int driverBuiltCount = 0;
  @override
  ReadDriver buildDriver(BuildContext context) {
    driverBuiltCount++;
    return ReadDriver(context);
  }

  @override
  ReadDriver buildTestDriver() {
    throw UnimplementedError();
  }
}

class ReadWidget extends DrivableWidget<ReadDriver> {
  final ReadDriverProvider? provider;

  ReadWidget({
    Key? key,
    RuntimeEnvironmentInfo? environmentInfo,
    this.provider,
  }) : super(key: key, environmentInfo: environmentInfo);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  WidgetDriverProvider<ReadDriver> get driverProvider => provider ?? ReadDriverProvider();
}
