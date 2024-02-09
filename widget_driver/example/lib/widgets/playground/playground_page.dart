import 'package:flutter/material.dart';

import 'playground_test_widget/playground_test_widget.dart';

class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: Text('Put your fun playground test code here')),
        PlaygroundTestWidget(),
      ],
    );
  }
}
