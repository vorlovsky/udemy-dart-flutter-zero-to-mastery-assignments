import 'package:flutter/material.dart';

class SolutionAlertDialog {
  static Widget build({required BuildContext context, required String solution}) {
    return AlertDialog(
      title: const Text('Solution'),
      content: Text(solution),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
