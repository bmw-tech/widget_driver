import 'dart:ui';

import 'package:widget_driver/widget_driver.dart';
import 'package:mocktail/mocktail.dart';

/// Use this class to provide mock version of your [WidgetDriver] in your widget tests.
/// By default, when a widget is running in a test environment, then it will use the hardcoded TestDriver.
/// But when you are testing your widget, then you probably want to mock the driver which belongs to that widget.
/// For that purpose you can use this [MockDriver].
///
/// Here is an example of how that might look like:
///
/// ```dart
/// class MockHomePageDriver extends MockDriver implements HomePageDriver {}
/// ...
/// late MockHomePageDriver mockHomePageDriver;
/// ...
/// setUp(() {
///   mockHomePageDriver = MockHomePageDriver();
///   when(() => mockHomePageDriver.numberOfTabs).thenReturn(3);
/// }
/// ...
/// homePage = MockDriverProvider<HomePageDriver>(
///   value: mockHomePageDriver,
///   child: HomePage(),
/// );
/// ```
class MockDriver<FC extends FlowCoordinator> extends Mock
    implements WidgetDriver<FC> {
  VoidCallback? listener;

  MockDriver() {
    when(() => addListener(any())).thenAnswer((invocation) {
      listener = invocation.positionalArguments.first as VoidCallback;
    });
    when(() => notifyWidget()).thenAnswer((_) {
      if (listener != null) {
        listener!();
      }
      return;
    });
    when(() => dispose()).thenAnswer((_) {});
  }
}
