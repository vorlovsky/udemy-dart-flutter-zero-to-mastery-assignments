import 'dart:math';

import 'package:flutter/material.dart';

class FloatingActionsPanel extends StatelessWidget {
  const FloatingActionsPanel(
      {super.key,
      int? questionsCount,
      required void Function() onAddQuestion,
      required void Function(int) onShowQuestion})
      : _questionsCount = questionsCount ?? 0,
        _onAddQuestion = onAddQuestion,
        _onShowQuestion = onShowQuestion;

  final int _questionsCount;
  final void Function() _onAddQuestion;
  final void Function(int) _onShowQuestion;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      FloatingActionButton(
        heroTag: 'add_question',
        onPressed: () => _onAddQuestion(),
        tooltip: 'Add question',
        enableFeedback: true,
        child: const Icon(Icons.add),
      ),
    ];

    if (_questionsCount > 0) {
      widgets.insert(
          0,
          FloatingActionButton(
            heroTag: 'random_question',
            onPressed: () {
              int index = Random().nextInt(_questionsCount);
              _onShowQuestion(index);
            },
            tooltip: 'Random question',
            enableFeedback: true,
            child: const Icon(Icons.radar),
          ));
      widgets.insert(
          1,
          const SizedBox(
            height: 20,
          ));
    }

    return Wrap(
      direction: Axis.vertical,
      children: widgets,
    );
  }
}
