import 'dart:math';

import 'package:flutter/material.dart';

class FloatingActionsPanel extends StatelessWidget {
  const FloatingActionsPanel(
      {super.key, int? questionsCount, required void Function(int) onShowQuestion})
      : _questionsCount = questionsCount ?? 0,
        _onShowQuestion = onShowQuestion;

  final int _questionsCount;
  final void Function(int) _onShowQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _questionsCount > 0
          ? FloatingActionButton(
              heroTag: 'random_question',
              onPressed: () {
                int index = Random().nextInt(_questionsCount);
                _onShowQuestion(index);
              },
              tooltip: 'Random question',
              enableFeedback: true,
              child: const Icon(Icons.radar),
            )
          : null,
    );
  }
}
