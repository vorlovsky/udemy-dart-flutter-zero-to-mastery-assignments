import 'package:flutter/material.dart';
import 'package:task_f9/model/question.dart';
import 'package:task_f9/presentation/question_details_screen/question_details_screen.dart';
import 'package:task_f9/presentation/question_screen/widgets/floating_actions_panel.dart';
import 'package:task_f9/presentation/question_screen/widgets/questions_list.dart';
import 'package:task_f9/utils/navigation.dart';

class QuestionsArguments {
  QuestionsArguments(this.questions);

  final List<Question> questions;
}

class QuestionsScreen extends StatelessWidget {
  static const String routeName = '/questions';

  const QuestionsScreen({super.key, required this.arguments});

  final QuestionsArguments arguments;

  void _showQuestionDetails({required BuildContext context, required Question question}) {
    pushNamedRoute(
      context,
      QuestionDetailsScreen.routeName,
      arguments: QuestionDetailsArguments(question),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = arguments.questions;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Questions Screen'),
        ),
        body: QuestionsList(
            questions: questions,
            onSelectQuestion: (question) => _showQuestionDetails(
                  context: context,
                  question: question,
                )),
        floatingActionButton: FloatingActionsPanel(
          questionsCount: questions.length,
          onShowQuestion: (index) => _showQuestionDetails(
            context: context,
            question: questions[index],
          ),
        ));
  }
}
