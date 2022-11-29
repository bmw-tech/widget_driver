import 'package:flutter/widgets.dart';

/// Manages the coordination of ui flow.
///
/// The idea is to seperate out the presentation logic out from
/// the widget, and instead let the widget only focus on defininig how its ui should look like.
/// The [FlowCoordinator] is be responsible creating the widgets and it knows how to present/dismiss them.
abstract class FlowCoordinator {
  BuildContext context;

  FlowCoordinator(this.context);
}
