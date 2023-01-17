import 'package:example/widgets/home_page/home_page.dart';
import 'package:example/widgets/home_page/home_page_driver.dart';
import 'package:example/widgets/home_page/tabs/home_page_tabs.dart';
import 'package:example/widgets/home_page/tabs/home_page_tabs_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:widget_driver_test/widget_driver_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomePageDriver extends MockDriver implements HomePageDriver {}

void main() {
  group('HomePage:', () {
    late Widget homePage;
    late MockHomePageDriver mockHomePageDriver;

    setUp(() {
      // Setup the default values for MockDriver for HomePage
      mockHomePageDriver = MockHomePageDriver();
      when(() => mockHomePageDriver.title).thenReturn('Hey this is a mocked title');
      when(() => mockHomePageDriver.numberOfTabs).thenReturn(3);
      when(() => mockHomePageDriver.appTabs).thenReturn([
        AppTabType.consumption,
        AppTabType.community,
        AppTabType.consumption,
      ]);

      // The HomePage widget contains a 'Scaffold' and these need
      // to be contained inside a Material app to be able to render.
      // So lets wrap our HomePage in a 'MaterialApp'.
      homePage = MockDriverProvider<HomePageDriver>(
        value: mockHomePageDriver,
        child: MaterialApp(home: HomePage()),
      );
    });

    testWidgets('Contains a TabController', (WidgetTester tester) async {
      await tester.pumpWidget(homePage);
      final tabControllerFinder = find.byType(DefaultTabController);
      expect(tabControllerFinder, findsOneWidget);
    });

    testWidgets('Has correct title', (WidgetTester tester) async {
      const mockTitle = 'Hey this is a mocked title';
      const mockOtherTitle = 'Some other title';

      when(() => mockHomePageDriver.title).thenReturn(mockTitle);

      await tester.pumpWidget(homePage);

      expect(find.text(mockTitle), findsOneWidget);
      expect(find.text(mockOtherTitle), findsNothing);

      // Try changing the title and verify it updates correctly
      when(() => mockHomePageDriver.title).thenReturn(mockOtherTitle);
      mockHomePageDriver.notifyWidget();
      await tester.pumpWidget(homePage);

      expect(find.text(mockTitle), findsNothing);
      expect(find.text(mockOtherTitle), findsOneWidget);
    });

    testWidgets('TabController has correct amount of tabs', (WidgetTester tester) async {
      const mockAppTabs = [
        AppTabType.consumption,
        AppTabType.community,
        AppTabType.consumption,
      ];
      const mockOtherAppTabs = [
        AppTabType.community,
        AppTabType.consumption,
      ];

      when(() => mockHomePageDriver.numberOfTabs).thenReturn(mockAppTabs.length);
      when(() => mockHomePageDriver.appTabs).thenReturn(mockAppTabs);

      await tester.pumpWidget(homePage);

      DefaultTabController tabController =
          find.byType(DefaultTabController).evaluate().single.widget as DefaultTabController;
      expect(tabController.length, 3);

      // Try changing the appTabs and verify it updates correctly
      when(() => mockHomePageDriver.numberOfTabs).thenReturn(mockOtherAppTabs.length);
      when(() => mockHomePageDriver.appTabs).thenReturn(mockOtherAppTabs);
      mockHomePageDriver.notifyWidget();
      await tester.pumpAndSettle();

      tabController = find.byType(DefaultTabController).evaluate().single.widget as DefaultTabController;
      expect(tabController.length, 2);
    });

    testWidgets('TabController shows correct TabBarView when changing tab', (
      WidgetTester tester,
    ) async {
      const mockAppTabs = [AppTabType.consumption, AppTabType.community];
      when(() => mockHomePageDriver.numberOfTabs).thenReturn(mockAppTabs.length);
      when(() => mockHomePageDriver.appTabs).thenReturn(mockAppTabs);

      // Grab the generated widget for each appTab index
      final firstTabWidgetType = HomePageTabBuilder.tabForType(mockAppTabs[0]).runtimeType;
      final secondTabWidgetType = HomePageTabBuilder.tabForType(mockAppTabs[1]).runtimeType;

      // Verify that the AppTabs for different indices are different
      expect(firstTabWidgetType, isNot(equals(secondTabWidgetType)));

      await tester.pumpWidget(homePage);

      // Grab TabController and tap first tab and verify it shows correct widget
      TabBar tabController = find.byType(TabBar).first.evaluate().single.widget as TabBar;
      await tester.tap(find.byWidget(tabController.tabs[0]));
      await tester.pumpWidget(homePage);

      expect(find.byType(firstTabWidgetType), findsOneWidget);
      expect(find.byType(secondTabWidgetType), findsNothing);

      // Now try tapping on second tab and verify it shows correct widget
      await tester.tap(find.byWidget(tabController.tabs[1]));
      await tester.pumpAndSettle();

      expect(find.byType(firstTabWidgetType), findsNothing);
      expect(find.byType(secondTabWidgetType), findsOneWidget);
    });
  });
}
