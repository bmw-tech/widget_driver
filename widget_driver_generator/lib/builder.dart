library widget_driver_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/widget_driver_generator.dart';

/// source_gen helper function, which calls WidgetDriverGenerator to generate TestDrivers and WidgetDriverProviders
Builder generateWidgetDriver(BuilderOptions options) =>
    SharedPartBuilder([WidgetDriverGenerator(options: options)], 'widget_driver_generator');
