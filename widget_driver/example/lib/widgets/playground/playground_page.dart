import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorWidget();
  }
}

// ########### ColorWidget Driver stuff ###########

class ColorWidgetDriver extends WidgetDriver {
  bool _useRed = true;

  ColorWidgetDriver(BuildContext context) : super(context);

  String toggleColorButtonTitle = 'Toggle Color';

  String get selectedColorName => 'Selected color: ${_useRed ? 'Red' : 'Blue'}';

  MaterialColor get selectedColor => _useRed ? Colors.red : Colors.blue;

  void toggleColor() {
    _useRed = !_useRed;
    notifyWidget();
  }
}

class ColorWidgetDriverProvider extends WidgetDriverProvider<ColorWidgetDriver> {
  @override
  ColorWidgetDriver buildDriver(BuildContext context) {
    return ColorWidgetDriver(context);
  }

  @override
  ColorWidgetDriver buildTestDriver() {
    throw UnimplementedError();
  }
}

class ColorWidget extends DrivableWidget<ColorWidgetDriver> {
  ColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Parent Widget stuff'),
        ElevatedButton(
          onPressed: driver.toggleColor,
          child: Text(driver.toggleColorButtonTitle),
        ),
        Text(driver.selectedColorName),
        const Divider(thickness: 4),
        const Text('Child Widget stuff'),
        Provider.value(
          value: driver.selectedColor,
          child: const ColorDisplayerWidget(),
        ),
        const SizedBox(height: 20),
        Provider.value(
          value: driver.selectedColor,
          child: DrivableColorDisplayerWidget(passedInColor: driver.selectedColor),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<ColorWidgetDriver> get driverProvider => ColorWidgetDriverProvider();
}

// ########### Normal widget ###########

class ColorDisplayerWidget extends StatelessWidget {
  const ColorDisplayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.read<MaterialColor>();
    return Container(
      color: color,
      width: 200,
      height: 80,
      child: const Center(child: Text('Normal Stateless Widget')),
    );
  }
}

// ########### Drivable Widget ###########
class DrivableColorDisplayerWidget extends DrivableWidget<DrivableColorDisplayerWidgetDriver> {
  final MaterialColor passedInColor;

  DrivableColorDisplayerWidget({Key? key, required this.passedInColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: driver.selectedColor,
      width: 200,
      height: 80,
      child: const Center(child: Text('Drivable Widget')),
    );
  }

  @override
  WidgetDriverProvider<DrivableColorDisplayerWidgetDriver> get driverProvider =>
      DrivableColorDisplayerWidgetDriverProvider(passedInColor);
}

class DrivableColorDisplayerWidgetDriver extends WidgetDriver with $MixinProvidedProperties {
  final Locator _read;
  final MaterialColor _color;
  MaterialColor _passedInColor;

  DrivableColorDisplayerWidgetDriver(
    BuildContext context,
    @driverProvidableProperty MaterialColor passedInColor,
  )   : _read = context.read, // Getting data from the locator
        // _color = context.watch<MaterialColor>(), // Getting data from context which will update
        _color = context.read<MaterialColor>(), // Getting data from context which will not update
        _passedInColor = passedInColor,
        super(context);

  // MaterialColor get selectedColor => _read<MaterialColor>(); // get color from Locator
  // MaterialColor get selectedColor => _color; // get color from context
  MaterialColor get selectedColor => _passedInColor; // get color from passed in color

  MaterialColor get contextColor => _read<MaterialColor>();

  MaterialColor get oneTimeReadColor => _color;

  @override
  void updateProperties2(MaterialColor passedInColor) {
    _passedInColor = passedInColor;
  }
}

mixin $MixinProvidedProperties {
  void updateProperties2(MaterialColor passedInColor);
}

class DrivableColorDisplayerWidgetDriverProvider extends WidgetDriverProvider<DrivableColorDisplayerWidgetDriver> {
  final MaterialColor passedInColor;

  DrivableColorDisplayerWidgetDriverProvider(this.passedInColor);

  @override
  DrivableColorDisplayerWidgetDriver buildDriver(BuildContext context) {
    return DrivableColorDisplayerWidgetDriver(context, passedInColor);
  }

  @override
  DrivableColorDisplayerWidgetDriver buildTestDriver() {
    throw UnimplementedError();
  }

  @override
  void updateDriverProvidedProperties(DrivableColorDisplayerWidgetDriver driver) {
    // Dont forgot to add the mixin to your diver.. This is how you do it: example
    driver.updateProperties2(passedInColor);
  }
}
