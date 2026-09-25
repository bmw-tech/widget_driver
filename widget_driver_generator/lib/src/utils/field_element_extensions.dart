import 'package:analyzer/dart/element/element.dart';

extension FieldElementExtension on FieldElement {
  /// All getters are also treated as fields but have explicit getters.
  bool get isRedundantToPropertyAccessorElement => setter?.isSynthetic != true && getter?.isSynthetic != true;
}
