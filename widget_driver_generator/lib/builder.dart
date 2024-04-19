library widget_driver_generator;

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';

import 'src/widget_driver_generator.dart';

/// source_gen helper function, which calls WidgetDriverGenerator to generate TestDrivers and WidgetDriverProviders
Builder generateWidgetDriver(BuilderOptions options) {
  final customLineLength = options.config['lineLength'];
  if (customLineLength != null && customLineLength is! int) {
    throw Exception("lineLength specified in build.yaml that is not of type int");
  }
  return SharedPartBuilder(
    [WidgetDriverGenerator(options: options)],
    'widget_driver_generator',
    formatOutput: DartFormatter(pageWidth: customLineLength).format,
  );
}
