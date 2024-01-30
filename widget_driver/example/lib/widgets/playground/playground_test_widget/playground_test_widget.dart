import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'playground_test_child_widget.dart';
import 'playground_test_widget_driver.dart';

class PlaygroundTestWidget extends DrivableWidget<PlaygroundTestWidgetDriver> {
  PlaygroundTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.lightBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(driver.buttonHeaderText),
              ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print('Tap tap');
                },
                child: PlaygroundTestChildWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PlaygroundTestWidgetDriver> get driverProvider => $PlaygroundTestWidgetDriverProvider();
}
