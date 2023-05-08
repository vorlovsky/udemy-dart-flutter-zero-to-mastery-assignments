import 'package:flutter/material.dart';
import 'package:task_f9/presentation/add_question_screen/add_question_screen.dart';
import 'package:task_f9/presentation/question_details_screen/question_details_screen.dart';
import 'package:task_f9/presentation/questions_screen/questions_screen.dart';
import 'package:task_f9/presentation/root_container/root_container.dart';
import 'package:task_f9/utils/navigation.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task F9',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        snackBarTheme: const SnackBarThemeData(
            actionTextColor: Colors.white70,
            backgroundColor: Colors.blue,
            contentTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      home: const RootContainer(),
      routes: <String, WidgetBuilder>{
        RootContainer.routeName: (context) => const RootContainer(),
        QuestionsScreen.routeName:
            getRouteWIthArgumentsWidgetBuilder<QuestionsArguments>(QuestionsScreen.new),
        QuestionDetailsScreen.routeName:
            getRouteWIthArgumentsWidgetBuilder<QuestionDetailsArguments>(QuestionDetailsScreen.new),
        AddQuestionScreen.routeName:
            getRouteWIthArgumentsWidgetBuilder<AddQuestionArguments>(AddQuestionScreen.new),
      },
    );
  }
}
