import 'package:example/localization/localization.dart';
import 'package:example/widgets/my_app_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class MockLocalization extends Mock implements Localization {}

void main() {
  group('MyAppDriver:', () {
    late MockLocalization mockLocalization;

    setUp(() {
      mockLocalization = MockLocalization();
    });

    testWidgets('Shows correct app title', (WidgetTester tester) async {
      when(() => mockLocalization.appTitle).thenReturn('Some app title');

      final driverTester = await tester.getDriverTester<MyAppDriver>(
          driverBuilder: () => MyAppDriver(),
          parentWidgetBuilder: (driverWidget) {
            return Provider<Localization>.value(
              value: mockLocalization,
              child: driverWidget,
            );
          });

      final driver = driverTester.driver;
      expect(driver.appTitle, equals('Some app title'));
    });
  });
}
