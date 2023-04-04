import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

class Resolver extends DependencyResolver {
  Resolver(BuildContext context) : super(context);

  @override
  void registerTestDefaultFallbackValues() {}

  @override
  T? tryToGetDependencyFromBuildContext<T>(BuildContext context) {
    try {
      return context.read<T>();
    } catch (_) {}
    return null;
  }
}
