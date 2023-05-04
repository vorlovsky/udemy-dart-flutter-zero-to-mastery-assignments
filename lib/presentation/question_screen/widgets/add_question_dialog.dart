import 'package:flutter/material.dart';
import 'package:task_f7/config/question_category.dart';
import 'package:task_f7/model/question.dart';
import 'package:task_f7/presentation/question_screen/widgets/question_category_icon.dart';

class AddQuestionDialog extends StatefulWidget {
  static DropdownMenuItem<QuestionCategory> questionCategoryMapper(QuestionCategory category) {
    return DropdownMenuItem<QuestionCategory>(
      value: category,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionCategoryIcon(category: category, width: 20, height: 20),
          const SizedBox(width: 10),
          Text(category.name),
        ],
      ),
    );
  }

  final List<DropdownMenuItem<QuestionCategory>> categoryItems;
  final void Function(Question) onAdd;

  AddQuestionDialog(
      {super.key, required List<QuestionCategory> questionCategories, required this.onAdd})
      : categoryItems = questionCategories.map(questionCategoryMapper).toList();

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  QuestionCategory? questionCategory;
  String? questionText;

  bool get _isAllDataProvided =>
      questionCategory != null && questionText != null && questionText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Enter question data:'),
          elevation: 5,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
                child: DropdownButtonHideUnderline(
                  child: InputDecorator(
                    decoration:
                        InputDecoration(labelText: questionCategory != null ? 'Category' : null),
                    child: DropdownButton(
                      hint: const Text('Category'),
                      value: questionCategory,
                      items: widget.categoryItems,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      focusColor: Colors.blue,
                      onChanged: (QuestionCategory? value) =>
                          setState(() => questionCategory = value),
                    ),
                  ),
                ),
              ),
              Flexible(
                  child: TextField(
                maxLines: 1,
                decoration: const InputDecoration(labelText: 'Question text'),
                onChanged: (value) => setState(() => questionText = value),
              ))
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: _isAllDataProvided
                  ? () {
                      widget.onAdd(Question(category: questionCategory!, text: questionText!));

                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
