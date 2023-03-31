import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';

part 'coffee_counter_header_section_driver.g.dart';

@GenerateTestDriver()
class CoffeeCounterHeaderSectionDriver extends WidgetDriver {
  late Localization _localization;
  late int _coffeeCount;

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
    _coffeeCount = context.watch<int>();
  }

  @TestDriverDefaultValue('Consumed coffees')
  String get descriptionText => _localization.consumedCoffees;

  @TestDriverDefaultValue('3')
  String get amountText => '$_coffeeCount';
}
