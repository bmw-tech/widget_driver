import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

class Resolver extends DependencyResolver {
  Resolver(BuildContext context) : super(context);

  @protected
  @override
  void registerTestDefaultFallbackValues() {}

  @protected
  @override
  T? tryToGetDependencyFromBuildContext<T>(BuildContext context) {
    try {
      return context.read<T>();
    } catch (_) {}
    return null;
  }
}
