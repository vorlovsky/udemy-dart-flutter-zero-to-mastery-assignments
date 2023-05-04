import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task F1',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          snackBarTheme: const SnackBarThemeData(
              backgroundColor: Colors.black87,
              actionTextColor: Colors.blueAccent,
              contentTextStyle: TextStyle(color: Colors.white70, fontSize: 18))),
      home: const SnackbarPage(),
    );
  }
}

class SnackbarPage extends StatelessWidget {
  const SnackbarPage({super.key});

  static void showSnackbar(BuildContext context, String message,
      {SnackBarBehavior? behavior, SnackBarAction? action}) {
    AlignmentGeometry alignment = action == null ? Alignment.center : Alignment.centerLeft;

    SnackBar snackBar = SnackBar(
      content: Align(alignment: alignment, child: Text(message)),
      behavior: behavior,
      duration: const Duration(seconds: 3),
      action: action,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFixedSnackbarWithAction(BuildContext context) {
    SnackBarAction snackBarAction = SnackBarAction(
      label: 'OK',
      onPressed: () => showFloatingSnackbar(context),
    );

    showSnackbar(context, 'This one is a fixed snackbar', action: snackBarAction);
  }

  void showFloatingSnackbar(BuildContext context) {
    showSnackbar(context, 'And this one is a floating snackbar',
        behavior: SnackBarBehavior.floating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showFixedSnackbarWithAction(context),
        tooltip: 'Show snackbar',
        child: const Icon(Icons.add_box),
      ),
    );
  }
}
