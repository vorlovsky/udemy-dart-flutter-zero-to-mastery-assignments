import 'package:flutter/material.dart';

class HintSnackBar {
  static SnackBar build({required String hint}) {
    return SnackBar(
      content: Center(
        child: Text(hint),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
    );
  }
}
