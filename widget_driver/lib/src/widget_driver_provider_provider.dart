import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

class WidgetDriverProviderProvider extends StatelessWidget {
  final Widget Function(Widget) providers;
  final Widget Function(Widget)? testProviders;
  final Widget child;
  final RuntimeEnvironmentInfo _runtimeEnvironmentInfo;

  WidgetDriverProviderProvider({
    Key? key,
    required this.providers,
    this.testProviders,
    required this.child,
  })  : _runtimeEnvironmentInfo = RuntimeEnvironmentInfo(),
        super(key: key);

  @visibleForTesting
  WidgetDriverProviderProvider.forTesting({
    Key? key,
    required this.providers,
    this.testProviders,
    required this.child,
    RuntimeEnvironmentInfo? runtimeEnvironmentInfo,
  })  : _runtimeEnvironmentInfo = runtimeEnvironmentInfo ?? RuntimeEnvironmentInfo(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_runtimeEnvironmentInfo.isRunningInTestEnvironment()) {
      return testProviders?.call(child) ?? child;
    } else {
      return providers.call(child);
    }
  }
}
