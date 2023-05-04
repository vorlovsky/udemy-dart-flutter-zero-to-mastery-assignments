import 'package:flutter/material.dart';
import 'package:task_f8/config/question_category.dart';
import 'package:task_f8/model/question.dart';
import 'package:task_f8/presentation/add_question_dialog/add_question_dialog.dart';
import 'package:task_f8/presentation/question_details_screen/question_details_screen.dart';
import 'package:task_f8/presentation/question_screen/widgets/Floating_actions_panel.dart';
import 'package:task_f8/presentation/question_screen/widgets/questions_list.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<Question> questions = [];

  void _addQuestion(Question question) {
    setState(() {
      questions.add(question);
    });
  }

  void _showAddQuestionDialog() {
    showDialog(
        context: context,
        builder: (context) =>
            AddQuestionDialog(questionCategories: QuestionCategory.values, onAdd: _addQuestion));
  }

  void _showQuestionDetails(Question question) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionDetailsScreen(question),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Questions Screen'),
        ),
        body: QuestionsList(questions: questions, onSelectQuestion: _showQuestionDetails),
        floatingActionButton: FloatingActionsPanel(
          questionsCount: questions.length,
          onAddQuestion: _showAddQuestionDialog,
          onShowQuestion: (index) => _showQuestionDetails(questions[index]),
        ));
  }
}
