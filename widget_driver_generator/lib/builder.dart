library widget_driver_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/widget_driver_generator.dart';

Builder generateWidgetDriver(BuilderOptions options) =>
    SharedPartBuilder([WidgetDriverGenerator()], 'widget_driver_generator');
