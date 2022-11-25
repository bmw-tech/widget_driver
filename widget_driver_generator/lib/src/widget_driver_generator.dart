import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

import 'model_visitor.dart';

class WidgetDriverGenerator extends GeneratorForAnnotation<Driver> {
  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();
    final driverClassName = visitor.className;
    final providerClassName = '\$${driverClassName}Provider';

    //###################################
    // Start - typedef generation
    //###################################

    final postfix = "DrivableWidget";
    String typedefName = driverClassName.replaceAll("WidgetDriver", postfix);
    if (typedefName == driverClassName) {
      typedefName = driverClassName.replaceAll("Driver", postfix);
    }
    if (typedefName == driverClassName) {
      typedefName = "${typedefName}${postfix}";
    }

    classBuffer.writeln('/// You can use this typedef as a base class for your DrivableWidget');
    classBuffer.writeln('///');
    classBuffer.writeln('/// ```dart');
    classBuffer.writeln('/// class MyCustomWidget extends \$${typedefName} {');
    classBuffer.writeln('///     ...');
    classBuffer.writeln('/// }');
    classBuffer.writeln('/// ```');
    classBuffer.writeln('typedef \$${typedefName} = DrivableWidget<${driverClassName}, ${providerClassName}>;');

    //###################################
    // Start - TestDriver generation
    //###################################

    final testDriverClassName = '_\$Test${driverClassName}';

    classBuffer.writeln('class $testDriverClassName extends TestDriver implements $driverClassName {');
    final annotationVisitor = AnnotationVisitor(classBuffer);
    element.visitChildren(annotationVisitor);
    classBuffer.writeln('}');

    //###################################
    // Start - DriverProvider generation
    //###################################

    classBuffer.writeln('class $providerClassName extends WidgetDriverProvider<$driverClassName> {');

    classBuffer.writeln('@override');
    classBuffer.writeln('$driverClassName buildDriver(BuildContext context) {');
    classBuffer.writeln('return $driverClassName(context);');
    classBuffer.writeln('}');

    classBuffer.writeln('@override');
    classBuffer.writeln('$driverClassName buildTestDriver() {');
    classBuffer.writeln('return $testDriverClassName();');
    classBuffer.writeln('}');

    classBuffer.writeln('}');

    return classBuffer.toString();
  }
}
