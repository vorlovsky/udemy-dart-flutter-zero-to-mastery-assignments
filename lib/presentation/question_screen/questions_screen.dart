import 'package:flutter/material.dart';
import 'package:task_f7/config/question_category.dart';
import 'package:task_f7/model/question.dart';
import 'package:task_f7/presentation/question_screen/widgets/add_question_dialog.dart';
import 'package:task_f7/presentation/question_screen/widgets/questions_list.dart';

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

  void _showAddQuestionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AddQuestionDialog(questionCategories: QuestionCategory.values, onAdd: _addQuestion));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions Page'),
      ),
      body: QuestionsList(questions: questions),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddQuestionDialog(context),
        tooltip: 'Add question',
        child: const Icon(Icons.add),
      ),
    );
  }
}
