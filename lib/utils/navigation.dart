import 'package:flutter/material.dart';

WidgetBuilder getRouteWIthArgumentsWidgetBuilder<T>(
    Widget Function({required T arguments}) creator) {
  return (BuildContext context) {
    final T arguments = ModalRoute.of(context)!.settings.arguments as T;

    return creator(arguments: arguments);
  };
}

void pushNamedRoute(BuildContext context, String routeName, {Object? arguments}) {
  Navigator.pushNamed(
    context,
    routeName,
    arguments: arguments,
  );
}

void popRoute(BuildContext context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}
