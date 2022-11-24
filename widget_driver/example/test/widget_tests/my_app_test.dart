import 'package:example/widgets/home_page/home_page.dart';
import 'package:example/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MyApp:", () {
    testWidgets("Contains a MaterialApp", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final materialAppFinder = find.byType(MaterialApp);
      expect(materialAppFinder, findsOneWidget);
    });

    testWidgets("Contains a HomePage", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final homePageFinder = find.byType(HomePage);
      expect(homePageFinder, findsOneWidget);
    });
  });
}
