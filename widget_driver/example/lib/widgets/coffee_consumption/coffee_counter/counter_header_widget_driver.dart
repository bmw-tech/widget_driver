import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../models/consumed_coffees_count.dart';

part 'counter_header_widget_driver.g.dart';

@GenerateTestDriver()
class CounterHeaderWidgetDriver extends WidgetDriver {
  late ConsumedCoffeesCount _consumedCoffeesCount;
  final Locator _locator;

  CounterHeaderWidgetDriver(BuildContext context)
      : _consumedCoffeesCount = context.watch<ConsumedCoffeesCount>(),
        _locator = context.read,
        super(context);

  @TestDriverDefaultValue('Consumed coffees')
  String get descriptionText => _locator<Localization>().consumedCoffees;

  @TestDriverDefaultValue('3')
  String get amountText => '${_consumedCoffeesCount.count}';

  @override
  void didUpdateBuildContextDependencies(BuildContext context) {
    _consumedCoffeesCount = context.watch<ConsumedCoffeesCount>();
  }
}
