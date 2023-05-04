import 'package:flutter/material.dart';
import 'package:task_f9/config/question_category.dart';
import 'package:task_f9/model/question.dart';
import 'package:task_f9/presentation/add_question_screen/widgets/hint_input_item.dart';
import 'package:task_f9/presentation/add_question_screen/widgets/question_category_picker.dart';
import 'package:task_f9/presentation/components/flexible_text_field.dart';

class AddQuestionArguments {
  AddQuestionArguments({List<QuestionCategory>? questionCategories, required this.onAdd})
      : questionCategories = questionCategories ?? QuestionCategory.values;

  final List<QuestionCategory> questionCategories;
  final void Function(Question) onAdd;
}

class AddQuestionScreen extends StatefulWidget {
  static const String routeName = '/addQuestion';

  const AddQuestionScreen({super.key, required this.arguments});

  final AddQuestionArguments arguments;

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  QuestionCategory? category;
  TextEditingController textController = TextEditingController();
  TextEditingController solutionController = TextEditingController();
  List<String> hints = [];

  bool get _isAllDataProvided =>
      category != null && textController.text.isNotEmpty && solutionController.text.isNotEmpty;

  void onAddQuestion() {
    addQuestion();
    clear();
  }

  void addQuestion() {
    widget.arguments.onAdd(Question(
      category: category!,
      text: textController.text,
      solution: solutionController.text,
      hints: hints.where((String element) => element.isNotEmpty).toList(),
    ));
  }

  void clear() {
    textController.clear();
    solutionController.clear();

    setState(() {
      category = null;
      hints = [];
    });

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestionCategoryPicker(
                questionCategories: widget.arguments.questionCategories,
                value: category,
                onChanged: (value) => setState(() => category = value),
              ),
              FlexibleTextField(
                controller: textController,
                labelText: 'Question text',
                onChanged: (value) => setState(() {}),
              ),
              FlexibleTextField(
                controller: solutionController,
                labelText: 'Solution text',
                onChanged: (value) => setState(() {}),
              ),
              ...hints.asMap().entries.map((entry) => HintInputItem(
                    onChanged: (value) => setState(() => hints[entry.key] = value),
                    onRemove: () => setState(() => hints.removeAt(entry.key)),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      hints.add('');
                    });
                  },
                  child: const Text('Add hint'))
            ],
          ),
        ),
      ),
      floatingActionButton: _isAllDataProvided
          ? FloatingActionButton(
              tooltip: 'Add question',
              enableFeedback: true,
              onPressed: onAddQuestion,
              child: const Icon(Icons.add))
          : null,
    );
  }
}
