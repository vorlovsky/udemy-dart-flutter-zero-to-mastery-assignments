import 'package:flutter/material.dart';

class CompleteMessage extends StatelessWidget {
  const CompleteMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Correct!');
  }
}

class SolutionMessage extends StatelessWidget {
  const SolutionMessage({
    super.key,
    required this.solution,
  });

  final String solution;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Solution'),
        const SizedBox(height: 10),
        Text(solution),
      ],
    );
  }
}

class HintMessage extends StatelessWidget {
  const HintMessage({
    super.key,
    required this.hint,
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Hint:'),
        const SizedBox(height: 10),
        Text(hint),
      ],
    );
  }
}
