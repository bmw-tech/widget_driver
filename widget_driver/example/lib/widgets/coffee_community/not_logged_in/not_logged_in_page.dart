import 'package:flutter/material.dart';

class NotLoggedInPage extends StatelessWidget {
  const NotLoggedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      // TODO: Handle localization
      child: Text("Not Logged In"),
    );
  }
}
