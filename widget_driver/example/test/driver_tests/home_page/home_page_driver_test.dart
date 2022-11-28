import 'package:example/localization/localization.dart';
import 'package:example/widgets/home_page/home_page_driver.dart';
import 'package:example/widgets/home_page/tabs/home_page_tabs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class MockLocalization extends Mock implements Localization {}

class MockHomePageAppTabs extends Mock implements HomePageAppTabs {}

void main() {
  group('HomePageDriver:', () {
    late MockLocalization mockLocalization;
    late MockHomePageAppTabs mockHomePageAppTabs;

    setUp(() {
      mockLocalization = MockLocalization();
      mockHomePageAppTabs = MockHomePageAppTabs();
    });

    testWidgets('Shows correct title', (WidgetTester tester) async {
      when(() => mockLocalization.appTitle).thenReturn('Some title');

      final driverTester = await tester.getDriverTester<HomePageDriver>(
          driverBuilder: (context) => HomePageDriver(context, appTabs: mockHomePageAppTabs),
          parentWidgetBuilder: (driverWidget) {
            return Provider<Localization>.value(
              value: mockLocalization,
              child: driverWidget,
            );
          });

      final driver = driverTester.driver;

      expect(driver.title, equals('Some title'));

      when(() => mockLocalization.appTitle).thenReturn('Some other title');
      expect(driver.title, equals('Some other title'));
    });

    testWidgets('Shows correct number of tabs', (WidgetTester tester) async {
      when(() => mockHomePageAppTabs.tabs).thenReturn([AppTabType.consumption]);

      final driverTester = await tester.getDriverTester<HomePageDriver>(
          driverBuilder: (context) => HomePageDriver(context, appTabs: mockHomePageAppTabs),
          parentWidgetBuilder: (driverWidget) {
            return Provider<Localization>.value(
              value: mockLocalization,
              child: driverWidget,
            );
          });

      final driver = driverTester.driver;

      expect(driver.numberOfTabs, equals(1));
      expect(driver.appTabs, equals([AppTabType.consumption]));

      when(() => mockHomePageAppTabs.tabs).thenReturn([AppTabType.consumption, AppTabType.community]);

      expect(driver.numberOfTabs, equals(2));
      expect(driver.appTabs, equals([AppTabType.consumption, AppTabType.community]));
    });
  });
}
