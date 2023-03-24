import 'dart:async';

import 'package:example/localization/localization.dart';
import 'package:example/services/auth_service.dart';
import 'package:example/widgets/home_page/log_in_out_button/log_in_out_button_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class MockLocalization extends Mock implements Localization {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('LogInOutButtonDriver:', () {
    late MockLocalization mockLocalization;
    late MockAuthService mockAuthService;
    late StreamController<bool> isLoggedInStreamController;

    setUp(() {
      mockLocalization = MockLocalization();
      mockAuthService = MockAuthService();
      isLoggedInStreamController = StreamController<bool>();

      when(() => mockLocalization.logIn).thenReturn('Log in');
      when(() => mockLocalization.logOut).thenReturn('Log out');
      when(() => mockAuthService.isLoggedInStream).thenAnswer((_) => isLoggedInStreamController.stream);
    });

    testWidgets('Shows correct button text', (WidgetTester tester) async {
      when(() => mockAuthService.isLoggedIn).thenReturn(false);

      final driverTester = await tester.getDriverTester<LogInOutButtonDriver>(
          driverBuilder: () => LogInOutButtonDriver(),
          parentWidgetBuilder: (driverWidget) {
            return MultiProvider(
              providers: [
                Provider<Localization>.value(value: mockLocalization),
                Provider<AuthService>.value(value: mockAuthService),
              ],
              child: driverWidget,
            );
          });

      final driver = driverTester.driver;
      expect(driver.buttonText, equals('Log in'));

      when(() => mockAuthService.isLoggedIn).thenReturn(true);
      expect(driver.buttonText, equals('Log out'));
    });

    testWidgets('Handles log in/out toggle button correctly', (WidgetTester tester) async {
      when(() => mockAuthService.isLoggedIn).thenReturn(false);

      final driverTester = await tester.getDriverTester<LogInOutButtonDriver>(
          driverBuilder: () => LogInOutButtonDriver(),
          parentWidgetBuilder: (driverWidget) {
            return MultiProvider(
              providers: [
                Provider<Localization>.value(value: mockLocalization),
                Provider<AuthService>.value(value: mockAuthService),
              ],
              child: driverWidget,
            );
          });

      final driver = driverTester.driver;
      driver.toggleLogInOut();
      verify(() => mockAuthService.logIn()).called(1);
      verifyNever(() => mockAuthService.logOut());

      when(() => mockAuthService.isLoggedIn).thenReturn(true);
      driver.toggleLogInOut();
      verifyNever(() => mockAuthService.logIn());
      verify(() => mockAuthService.logOut()).called(1);
    });

    testWidgets('When isLoggedInStream emits then notifyWidgets is called', (WidgetTester tester) async {
      final driverTester = await tester.getDriverTester<LogInOutButtonDriver>(
          driverBuilder: () => LogInOutButtonDriver(),
          parentWidgetBuilder: (driverWidget) {
            return MultiProvider(
              providers: [
                Provider<Localization>.value(value: mockLocalization),
                Provider<AuthService>.value(value: mockAuthService),
              ],
              child: driverWidget,
            );
          });

      isLoggedInStreamController.add(true);
      isLoggedInStreamController.add(false);

      // Wait for the driver to receive 2 notifyWidget calls.
      await driverTester.waitForNotifyWidget(numberOfCalls: 2, requireExactNumberOfCalls: true);
      // Verify no more calls to `notifyWidget`
      await driverTester.verifyNoMoreCallsToNotifyWidget();
    });
  });
}
