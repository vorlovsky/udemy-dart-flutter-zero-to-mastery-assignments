import 'package:flutter/material.dart';

class QuestionsListDivider extends StatelessWidget {
  const QuestionsListDivider({super.key, required Axis layoutDirection})
      : _layoutDirection = layoutDirection;

  final Axis _layoutDirection;

  @override
  Widget build(BuildContext context) {
    return _layoutDirection == Axis.vertical
        ? const Divider(
            color: Colors.blue,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          )
        : const VerticalDivider(
            color: Colors.blue,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          );
  }
}
