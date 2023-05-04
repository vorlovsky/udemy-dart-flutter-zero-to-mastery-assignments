import 'package:flutter/material.dart';
import 'package:task_f9/model/question.dart';
import 'package:task_f9/presentation/components/expanded_text_field.dart';
import 'package:task_f9/presentation/components/question_category_icon.dart';
import 'package:task_f9/presentation/question_details_screen/widgets/hint_snack_bar.dart';
import 'package:task_f9/presentation/question_details_screen/widgets/solution_alert_dialog.dart';
import 'package:task_f9/utils/navigation.dart';

class QuestionDetailsArguments {
  const QuestionDetailsArguments(this.question);

  final Question question;
}

class QuestionDetailsScreen extends StatefulWidget {
  static const String routeName = '/questionDetails';

  const QuestionDetailsScreen({super.key, required this.arguments});

  final QuestionDetailsArguments arguments;

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  _QuestionDetailsScreenState();

  late final Iterator<String> hintsIterator;

  Question get question => widget.arguments.question;

  String answer = '';
  bool isComplete = false;

  bool get isShowAnswerButton => answer.isNotEmpty && !isComplete;

  @override
  void initState() {
    super.initState();

    hintsIterator = question.hints;
  }

  void showHint(String hint, {void Function()? onClosed}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(HintSnackBar.build(hint: hint))
        .closed
        .then((reason) => onClosed?.call());
  }

  void showSolution() {
    showDialog(
      context: context,
      builder: (context) {
        return SolutionAlertDialog.build(
          context: context,
          solution: question.solution,
        );
      },
    ).then((value) => popRoute(context));
  }

  void checkAnswer() {
    if (answer == question.solution) {
      setState(() => isComplete = true);

      showHint('Correct!', onClosed: () => popRoute(context));
      return;
    }

    if (hintsIterator.moveNext()) {
      showHint('Hint: ${hintsIterator.current}');
    } else {
      setState(() => isComplete = true);

      showSolution();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question Details')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestionCategoryIcon(category: question.category, width: 70, height: 79),
              const SizedBox(height: 20),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(question.text),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: const Text('Your answer:'),
              ),
              const SizedBox(height: 5),
              ExpandedTextField(
                readOnly: isComplete,
                onChanged: (value) => setState(
                  () {
                    answer = value.trim();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: isShowAnswerButton
          ? FloatingActionButton(
              tooltip: 'Answer the question',
              enableFeedback: true,
              onPressed: checkAnswer,
              child: const Icon(Icons.question_answer))
          : null,
    );
  }
}
