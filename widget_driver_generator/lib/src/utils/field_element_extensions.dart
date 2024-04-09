import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/element.dart';

extension FieldElementExtension on FieldElement {
  /// All getters are also treated as fields but have explicit getters.
  bool get isRedundantToPropertyAccessorElement =>
      setter is! PropertyAccessorElementImpl_ImplicitSetter && getter is! PropertyAccessorElementImpl_ImplicitGetter;
}
