class ClassUtils {
  static String testDriverClassName(String className) => '_\$Test$className';

  static String driverProviderClassName(String className) => '\$${className}Provider';

  static String providedPropertiesMixinClassName() => '_\$DriverProvidedPropertiesMixin';
}
