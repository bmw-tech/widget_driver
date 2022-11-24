import 'package:flutter/material.dart';

import '../../../localization/localization.dart';

class NotLoggedInPage extends StatelessWidget {
  const NotLoggedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(Localization.notLoggedIn),
    );
  }
}
