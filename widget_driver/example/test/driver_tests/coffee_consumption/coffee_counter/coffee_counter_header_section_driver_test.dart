import 'package:example/localization/localization.dart';
import 'package:example/widgets/coffee_consumption/coffee_counter/coffee_counter_header_section_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class MockLocalization extends Mock implements Localization {}

void main() {
  late MockLocalization mockLocalization;
  ValueNotifier<int> fakeCoffeeCountNotifier = ValueNotifier<int>(0);

  setUp(() {
    mockLocalization = MockLocalization();
  });

  Future<DriverTester<CoffeeCounterHeaderSectionDriver>> _getDriver(WidgetTester tester) async {
    return tester.getDriverTester(
      driverBuilder: () => CoffeeCounterHeaderSectionDriver(),
      parentWidgetBuilder: (driverWidget) {
        return UpdatableDependency<int>(
          valueNotifier: fakeCoffeeCountNotifier,
          builder: (coffeeCount) {
            return MultiProvider(
              providers: [
                Provider<Localization>.value(value: mockLocalization),
                Provider<int>.value(value: coffeeCount),
              ],
              child: driverWidget,
            );
          },
        );
      },
    );
  }

  group('CoffeeCounterHeaderSectionDriver:', () {
    group('Properties:', () {
      testWidgets('Has correct value for descriptionText', (tester) async {
        const expectedText = 'Some text about consumed coffees';
        when(() => mockLocalization.consumedCoffees).thenReturn(expectedText);

        final driverTester = await _getDriver(tester);
        expect(driverTester.driver.descriptionText, expectedText);
      });

      testWidgets('Has correct value for amountText', (tester) async {
        fakeCoffeeCountNotifier.value = 123;

        final driverTester = await _getDriver(tester);
        expect(driverTester.driver.amountText, '123');
      });
    });

    group('Did update BuildContext:', () {
      testWidgets('amount text updates when count coming from context updates', (tester) async {
        // The initial value used when driver is created
        fakeCoffeeCountNotifier.value = 123;

        final driverTester = await _getDriver(tester);
        expect(driverTester.driver.amountText, '123');

        // Set a new value to the coffee count and trigger widget tester to render the update.
        fakeCoffeeCountNotifier.value = 124;
        await tester.pumpAndSettle();
        expect(driverTester.driver.amountText, '124');
      });
    });
  });
}
