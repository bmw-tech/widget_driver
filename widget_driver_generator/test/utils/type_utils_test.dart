import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_generator/src/utils/type_utils.dart';

void main() {
  group('TypeUtils:', () {
    test('Returns type name without <dynamic> for type with generics', () {
      expect(TypeUtils.getTypeName(_MyGenericClass), '_MyGenericClass');
    });

    test('Returns type name for type without generics', () {
      expect(TypeUtils.getTypeName(_MyNotGenericClass), '_MyNotGenericClass');
    });
  });
}

class _MyGenericClass<T> {}

class _MyNotGenericClass<T> {}
