import 'package:flutter/material.dart';

class AnimatedDialogConatiner extends StatefulWidget {
  AnimatedDialogConatiner({
    super.key,
    required this.child,
    Offset? startOffset,
    required this.bounds,
    required this.animationController,
  }) : startOffset = startOffset ?? Offset(bounds.width / 2, bounds.height / 2);

  final Widget child;
  final Offset startOffset;
  final Size bounds;
  final Animation<double> animationController;

  Offset get boundsCenter => Offset(bounds.width / 2, bounds.height / 2);

  late final CurvedAnimation rootAnimation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeOut,
  );

  @override
  State<AnimatedDialogConatiner> createState() => _AnimatedDialogConatinerState();
}

class _AnimatedDialogConatinerState extends State<AnimatedDialogConatiner> {
  Animation<Rect?>? rectAnimation;

  static Rect getCenteredRect(Offset center, Size size) => Rect.fromLTWH(
        center.dx - size.width / 2,
        center.dy - size.height / 2,
        size.width,
        size.height,
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateRectAnimation();
    });

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedDialogConatiner oldWidget) {
    updateRectAnimation();

    super.didUpdateWidget(oldWidget);
  }

  void updateRectAnimation() {
    final renderBox = context.findRenderObject() as RenderBox;

    rectAnimation = RectTween(
      begin: getCenteredRect(widget.startOffset, renderBox.size),
      end: getCenteredRect(widget.boundsCenter, renderBox.size),
    ).animate(widget.rootAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return rectAnimation == null
        ? Opacity(
            opacity: 0,
            child: widget.child,
          )
        : RelativePositionedTransition(
            size: widget.bounds,
            rect: rectAnimation!,
            child: ScaleTransition(
              scale: widget.rootAnimation,
              child: widget.child,
            ),
          );
  }
}
