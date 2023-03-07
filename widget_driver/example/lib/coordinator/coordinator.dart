import 'package:flutter/material.dart';

class Coordinator {
  void pushMaterialPageRoute({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: builder,
      ),
    );
  }

  void pop({required BuildContext context}) {
    Navigator.pop(context);
  }
}
