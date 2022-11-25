// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_community_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $CoffeeCommunityPageDrivableWidget {
///     ...
/// }
/// ```
typedef $CoffeeCommunityPageDrivableWidget = DrivableWidget<
    CoffeeCommunityPageDriver, $CoffeeCommunityPageDriverProvider>;

class _$TestCoffeeCommunityPageDriver extends TestDriver
    implements CoffeeCommunityPageDriver {
  @override
  bool get isLoggedIn => false;
}

class $CoffeeCommunityPageDriverProvider
    extends WidgetDriverProvider<CoffeeCommunityPageDriver> {
  @override
  CoffeeCommunityPageDriver buildDriver(BuildContext context) {
    return CoffeeCommunityPageDriver(context);
  }

  @override
  CoffeeCommunityPageDriver buildTestDriver() {
    return _$TestCoffeeCommunityPageDriver();
  }
}
