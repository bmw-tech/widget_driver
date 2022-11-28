import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widget_driver_test.dart';

typedef WidgetBuilder = Widget Function(Widget driverWidget);

extension Driver on WidgetTester {
  Future<DriverTester<T>> getDriverTester<T extends WidgetDriver>({
    required T Function(BuildContext) driverBuilder,
    WidgetBuilder? parentWidgetBuilder,
  }) async {
    T? driver;
    Widget driverWidget = _DriverContainerWidget<T>(
      builder: (context) {
        driver = driverBuilder(context);
      },
    );
    Widget widget = driverWidget;
    if (parentWidgetBuilder != null) {
      widget = parentWidgetBuilder(driverWidget);
    }
    await pumpWidget(widget);

    return DriverTester<T>(driver!, this);
  }
}

class _DriverContainerWidget<T extends WidgetDriver> extends StatelessWidget {
  final void Function(BuildContext) _driverBuilder;

  _DriverContainerWidget({
    Key? key,
    required void Function(BuildContext) builder,
  })  : _driverBuilder = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _driverBuilder(context);
    return const Placeholder();
  }
}
