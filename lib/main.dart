import 'package:flutter/material.dart';
import 'package:task_f8/presentation/question_screen/questions_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task F8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        snackBarTheme: const SnackBarThemeData(
            actionTextColor: Colors.white70,
            backgroundColor: Colors.blue,
            contentTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      home: const QuestionsScreen(),
    );
  }
}
