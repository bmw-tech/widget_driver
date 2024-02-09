import 'package:example/widgets/playground/playground_test_widget/playground_test_child_widget.dart';
import 'package:example/widgets/playground/playground_test_widget/playground_test_child_widget_driver.dart';
import 'package:example/widgets/playground/playground_test_widget/playground_test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';

void main() {
  group('PlaygroundTestWidget:', () {
    testWidgets('Some test where we make sure the PlaygroundTestChildWidget uses real driver',
        (WidgetTester tester) async {
      final playgroundTestWidget = PlaygroundTestWidget();

      // We wrap our `PlaygroundTestWidget` in a test config provider
      // and say that we want a real driver for `PlaygroundTestChildWidgetDriver`.
      final containerWidget = WidgetDriverTestConfigProvider(
        config: UseRealDriversForSomeTestConfig(useRealDriversFor: {
          PlaygroundTestChildWidgetDriver,
        }),
        child: playgroundTestWidget,
      );

      await tester.pumpWidget(MaterialApp(home: containerWidget));

      // Here we are verifying that the PlaygroundTestChildWidget is using the real driver
      expect(
        tester.widget(find.byType(PlaygroundTestChildWidget)),
        isA<PlaygroundTestChildWidget>().having((w) => w.driver is TestDriver, 'driver', isFalse),
      );

      // And here we verify that the PlaygroundTestWidget is using the test driver
      expect(
        tester.widget(find.byType(PlaygroundTestWidget)),
        isA<PlaygroundTestWidget>().having((w) => w.driver is TestDriver, 'driver', isTrue),
      );
    });

    testWidgets('Some test where we make sure that all drivable widgets uses real drivers',
        (WidgetTester tester) async {
      final playgroundTestWidget = PlaygroundTestWidget();

      // We wrap our `PlaygroundTestWidget` in a test config provider
      // and say that we want a real driver for all DrivableWidgets.
      final containerWidget = WidgetDriverTestConfigProvider(
        config: AlwaysUseRealDriversTestConfig(),
        child: playgroundTestWidget,
      );

      await tester.pumpWidget(MaterialApp(home: containerWidget));

      // Here we are verifying that the PlaygroundTestChildWidget is using the real driver
      expect(
        tester.widget(find.byType(PlaygroundTestChildWidget)),
        isA<PlaygroundTestChildWidget>().having((w) => w.driver is TestDriver, 'driver', isFalse),
      );

      // And here we verify that the PlaygroundTestWidget is using the real driver
      expect(
        tester.widget(find.byType(PlaygroundTestWidget)),
        isA<PlaygroundTestWidget>().having((w) => w.driver is TestDriver, 'driver', isFalse),
      );
    });

    testWidgets('Some test where we do not provide test config and we always want test drivers',
        (WidgetTester tester) async {
      final playgroundTestWidget = PlaygroundTestWidget();

      await tester.pumpWidget(MaterialApp(home: playgroundTestWidget));

      // Here we are verifying that the PlaygroundTestChildWidget is using the test driver
      expect(
        tester.widget(find.byType(PlaygroundTestChildWidget)),
        isA<PlaygroundTestChildWidget>().having((w) => w.driver is TestDriver, 'driver', isTrue),
      );

      // And here we verify that the PlaygroundTestWidget is using the test driver
      expect(
        tester.widget(find.byType(PlaygroundTestWidget)),
        isA<PlaygroundTestWidget>().having((w) => w.driver is TestDriver, 'driver', isTrue),
      );
    });
  });
}
