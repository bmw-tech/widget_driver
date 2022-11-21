import 'dart:ui';

import 'package:widget_driver/widget_driver.dart';
import 'package:mocktail/mocktail.dart';

class MockDriver<FC extends FlowCoordinator> extends Mock implements WidgetDriver<FC> {
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
