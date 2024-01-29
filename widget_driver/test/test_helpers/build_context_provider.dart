import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// A helper class which you can use when you need access to a build context in your tests
class BuildContextProvider {
  WidgetTester widgetTester;
  Widget Function(Widget childWidget)? dependencyProviderWidget;

  BuildContextProvider(this.widgetTester, {this.dependencyProviderWidget});

  Future<void> performAction(void Function(BuildContext context) contextProvidingCallback) async {
    Widget Function(Widget childWidget) widgetBuilder;
    if (dependencyProviderWidget != null) {
      widgetBuilder = dependencyProviderWidget!;
    } else {
      widgetBuilder = (childWidget) {
        return Container(child: childWidget);
      };
    }

    final contextProvidingWidget = Builder(builder: (context) {
      contextProvidingCallback(context);
      return Container();
    });

    final widget = widgetBuilder(contextProvidingWidget);
    await widgetTester.pumpWidget(widget);
  }
}
