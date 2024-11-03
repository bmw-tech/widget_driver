import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_test/widget_driver_test.dart';

class TestWidgetDriver extends MockDriver {}

void main() {
  late TestWidgetDriver testDriver;

  setUp(() {
    testDriver = TestWidgetDriver();
  });

  group('MockDriver:', () {
    test('Should add listener and notify widget', () {
      bool isNotified = false;
      listener() {
        isNotified = true;
      }

      testDriver.addListener(listener);
      testDriver.notifyWidget();

      expect(isNotified, isTrue);
    });

    test('Should dispose without errors', () {
      expect(() => testDriver.dispose(), returnsNormally);
    });

    test('Should not notify widget if no listener is added', () {
      expect(() => testDriver.notifyWidget(), returnsNormally);
    });
  });
}
