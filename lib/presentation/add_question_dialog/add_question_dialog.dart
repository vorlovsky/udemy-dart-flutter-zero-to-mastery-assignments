import 'package:flutter/material.dart';
import 'package:task_f8/config/question_category.dart';
import 'package:task_f8/model/question.dart';
import 'package:task_f8/presentation/add_question_dialog/widgets/hint_input_item.dart';
import 'package:task_f8/presentation/components/flexible_text_field.dart';
import 'package:task_f8/presentation/components/question_category_icon.dart';

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
  QuestionCategory? category;
  String? text;
  String? solution;
  List<String> hints = [];

  bool get _isAllDataProvided =>
      category != null &&
      text != null &&
      text!.isNotEmpty &&
      solution != null &&
      solution!.isNotEmpty;

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
                    decoration: InputDecoration(labelText: category != null ? 'Category' : null),
                    child: DropdownButton(
                      hint: const Text('Category'),
                      value: category,
                      items: widget.categoryItems,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      focusColor: Colors.blue,
                      onChanged: (QuestionCategory? value) => setState(() => category = value),
                    ),
                  ),
                ),
              ),
              FlexibleTextField(
                labelText: 'Question text',
                onChanged: (value) => setState(() => text = value),
              ),
              FlexibleTextField(
                labelText: 'Solution text',
                onChanged: (value) => setState(() => solution = value),
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
                      widget.onAdd(Question(
                        category: category!,
                        text: text!,
                        solution: solution!,
                        hints: hints.where((String element) => element.isNotEmpty).toList(),
                      ));

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
