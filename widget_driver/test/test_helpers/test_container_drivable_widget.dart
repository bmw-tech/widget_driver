import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

/// This is a Driver used by the unit tests.
/// Since `WidgetDriver` is just an abstract interface we
/// need some concrete instance which we can use in our tests.
/// This is the driver which is driving the `TestContainerDrivableWidget`.
class TestContainerDriver extends WidgetDriver {
  int someData;
  int? readDataValue;
  int? watchDataValue;

  final bool _readFromContext;
  final bool _watchFromContext;

  TestContainerDriver(
    BuildContext context, {
    int? newSomeData,
    required bool readFromContext,
    required bool watchFromContext,
  })  : _readFromContext = readFromContext,
        _watchFromContext = watchFromContext,
        someData = newSomeData ?? -1,
        super(context) {
    if (readFromContext) {
      readDataValue = context.read<ReadData>().value;
    }
    if (watchFromContext) {
      watchDataValue = context.watch<WatchData>().value;
    }
  }

  String get aTestText => 'A test text';

  bool didCallTestMethod = false;
  void aTestMethod() {
    didCallTestMethod = true;
    notifyWidget();
  }

  int numberOfCallsToUpdateDriverProvidedProperties = 0;

  void didUpdateProvidedProperties({required int newSomeData}) {
    someData = newSomeData;
    numberOfCallsToUpdateDriverProvidedProperties += 1;
  }

  int numberOfCallsToUpdateBuildContextDependencies = 0;

  @override
  void didUpdateBuildContextDependencies(BuildContext context) {
    numberOfCallsToUpdateBuildContextDependencies += 1;

    if (_readFromContext) {
      readDataValue = context.read<ReadData>().value;
    }
    if (_watchFromContext) {
      watchDataValue = context.watch<WatchData>().value;
    }
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
  final int _someData;
  final bool _readFromContext;
  final bool _watchFromContext;

  TestContainerDriverProvider({
    int? someData,
    bool? readFromContext,
    bool? watchFromContext,
  })  : _someData = someData ?? -1,
        _readFromContext = readFromContext ?? false,
        _watchFromContext = watchFromContext ?? false;

  @override
  TestContainerDriver buildDriver(BuildContext context) {
    return TestContainerDriver(
      context,
      newSomeData: _someData,
      readFromContext: _readFromContext,
      watchFromContext: _watchFromContext,
    );
  }

  @override
  TestContainerDriver buildTestDriver() {
    return TestContainerTestDriver();
  }

  @override
  void updateDriverProvidedProperties(TestContainerDriver driver) {
    driver.didUpdateProvidedProperties(newSomeData: _someData);
  }
}

/// This is a DrivableWidget used by the unit tests.
/// Since `DrivableWidget` is just an abstract interface we
/// need some concrete instance which we can use in our tests.
/// The driver which drives this widget is a `TestContainerDriver`.
class TestContainerDrivableWidget extends DrivableWidget<TestContainerDriver> {
  final int someData;
  final bool? readFromContext;
  final bool? watchFromContext;

  final void Function(TestContainerDriver driver)? driverCallback;

  TestContainerDrivableWidget({
    Key? key,
    RuntimeEnvironmentInfo? environmentInfo,
    int? newSomeData,
    this.readFromContext,
    this.watchFromContext,
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
  WidgetDriverProvider<TestContainerDriver> get driverProvider => TestContainerDriverProvider(
        someData: someData,
        readFromContext: readFromContext,
        watchFromContext: watchFromContext,
      );
}

class WrappedTestContainer extends StatefulWidget {
  final RuntimeEnvironmentInfo environmentInfo;
  final Function(TestContainerDriver) driverCallback;
  final bool _readFromContext;
  final bool _watchFromContext;

  const WrappedTestContainer({
    Key? key,
    required this.environmentInfo,
    required this.driverCallback,
    bool? readFromContext,
    bool? watchFromContext,
  })  : _readFromContext = readFromContext ?? false,
        _watchFromContext = watchFromContext ?? false,
        super(key: key);

  @override
  State<StatefulWidget> createState() => WrappedTestContainerState();
}

class WrappedTestContainerState extends State<WrappedTestContainer> {
  int someData = 0;
  ReadData readData = ReadData(0);
  WatchData watchData = WatchData(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<ReadData>.value(value: readData),
          Provider<WatchData>.value(value: watchData),
        ],
        child: Column(
          children: [
            MaterialButton(
              key: const Key('increase_someData_button'),
              onPressed: () => setState(() {
                someData += 1;
                readData = ReadData(someData);
                watchData = WatchData(someData);
              }),
              child: const Text('Increase button'),
            ),
            MaterialButton(
              key: const Key('just_calls_set_state_button'),
              onPressed: () => setState(() {}),
              child: const Text('Just call setState button'),
            ),
            TestContainerDrivableWidget(
              newSomeData: someData,
              environmentInfo: widget.environmentInfo,
              driverCallback: widget.driverCallback,
              readFromContext: widget._readFromContext,
              watchFromContext: widget._watchFromContext,
            )
          ],
        ),
      ),
    );
  }
}

class ReadData {
  final int value;
  ReadData(this.value);
}

class WatchData {
  final int value;
  WatchData(this.value);
}
