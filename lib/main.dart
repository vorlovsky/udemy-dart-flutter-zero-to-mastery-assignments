import 'package:flutter/material.dart';
import 'package:task_f7/presentation/question_screen/questions_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task F7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuestionsScreen(),
    );
  }
}
