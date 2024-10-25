import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class TestWidgetDriver extends MockDriver {}

void main() {
  late TestWidgetDriver testDriver;

  setUp(() {
    testDriver = TestWidgetDriver();
  });

  test('should add listener and notify widget', () {
    bool isNotified = false;
    listener() {
      isNotified = true;
    }

    testDriver.addListener(listener);
    testDriver.notifyWidget();

    expect(isNotified, isTrue);
  });

  test('should dispose without errors', () {
    expect(() => testDriver.dispose(), returnsNormally);
  });

  test('should not notify widget if no listener is added', () {
    expect(() => testDriver.notifyWidget(), returnsNormally);
  });
}
