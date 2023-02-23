import 'package:widget_driver_generator/src/models/providable_field.dart';
import 'package:widget_driver_generator/src/utils/class_utils.dart';
import 'package:widget_driver_generator/src/utils/string_extensions.dart';

class ProvidedPropertiesMixinCodeProvider {
  final List<ProvidableField> _fields;
  final String _providedPropertiesMixinClassName;

  ProvidedPropertiesMixinCodeProvider({
    required List<ProvidableField> fields,
    required String driverClassName,
  })  : _fields = fields,
        _providedPropertiesMixinClassName = ClassUtils.providedPropertiesMixinClassName(driverClassName);

  String _parameters() => _fields.map((e) => 'required ${e.type} ${e.name.makeItNew()}').join(',');

  String get providedPropertiesMixinClass {
    if (_fields.isEmpty) {
      return '';
    } else {
      return '''
mixin $_providedPropertiesMixinClassName {
  void updateProvidedProperties({${_parameters()},});
}
''';
    }
  }
}
