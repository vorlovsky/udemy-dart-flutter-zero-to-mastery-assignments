import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  AnimatedFloatingActionButton(
      {super.key, required this.animationController, required this.onPressed, this.tooltip});

  final Animation<double> animationController;
  final void Function() onPressed;
  final String? tooltip;

  late final Animation<double> _animation = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInBack,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.center,
      child: FloatingActionButton(
        tooltip: tooltip,
        enableFeedback: true,
        onPressed: onPressed,
        child: const Icon(Icons.question_answer),
      ),
    );
  }
}
