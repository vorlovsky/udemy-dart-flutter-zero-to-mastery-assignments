import 'package:flutter/material.dart';
import 'package:task_f8/model/question.dart';
import 'package:task_f8/presentation/components/expanded_text_field.dart';
import 'package:task_f8/presentation/components/question_category_icon.dart';
import 'package:task_f8/presentation/question_details_screen/widgets/hint_snack_bar.dart';
import 'package:task_f8/presentation/question_details_screen/widgets/solution_alert_dialog.dart';

class QuestionDetailsScreen extends StatefulWidget {
  const QuestionDetailsScreen(this.question, {super.key});

  final Question question;

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  String answer = '';
  late Iterator<String> hintsIterator = widget.question.hints;
  bool isComplete = false;

  bool get isShowAnswerButton => answer.isNotEmpty && !isComplete;

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
          solution: widget.question.solution,
        );
      },
    ).then((value) => Navigator.of(context).pop());
  }

  void checkAnswer() {
    if (answer == widget.question.solution) {
      setState(() => isComplete = true);

      showHint('Correct!', onClosed: () => Navigator.of(context).pop());
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
              QuestionCategoryIcon(category: widget.question.category, width: 70, height: 79),
              const SizedBox(height: 20),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(widget.question.text),
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
