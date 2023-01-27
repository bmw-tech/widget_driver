/// Class representing a field annotated with the `@driverProvidableModel` annotation, to keep track of all the 
/// important data to generate fields, constructors and parameters.
class ProvidableField {
  final String name;
  final String type;
  final bool isRequired;
  final String? defaultValueCode;
  final bool isNamed;

  ProvidableField({
    required this.name,
    required this.type,
    required this.isRequired,
    required this.defaultValueCode,
    required this.isNamed,
  });
}
