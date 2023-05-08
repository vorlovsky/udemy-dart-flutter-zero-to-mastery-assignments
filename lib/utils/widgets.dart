import 'package:flutter/material.dart';

Offset? getWidgetCenter(BuildContext? widgetContext, BuildContext? targetContext) {
  final RenderBox widgetRenderBox = widgetContext?.findRenderObject() as RenderBox;

  if (!widgetRenderBox.hasSize) {
    return null;
  }

  final Size widgetSize = widgetRenderBox.size;
  Offset widgetGlobalOffset =
      widgetRenderBox.localToGlobal(Offset(widgetSize.width / 2, widgetSize.height / 2));

  if (targetContext == null) {
    return widgetGlobalOffset;
  }

  final RenderBox targetRenderBox = targetContext.findRenderObject() as RenderBox;
  Offset targetGlobalOffset = targetRenderBox.localToGlobal(Offset.zero);

  return Offset(
      widgetGlobalOffset.dx - targetGlobalOffset.dx, widgetGlobalOffset.dy - targetGlobalOffset.dy);
}
