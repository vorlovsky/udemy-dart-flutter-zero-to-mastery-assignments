import 'package:flutter/material.dart';
import 'package:task_f9/config/question_category.dart';
import 'package:task_f9/presentation/add_question_screen/widgets/category_menu_item.dart';

class QuestionCategoryPicker extends StatelessWidget {
  const QuestionCategoryPicker({
    super.key,
    required List<QuestionCategory> questionCategories,
    QuestionCategory? value,
    required void Function(QuestionCategory?) onChanged,
  })  : _questionCategories = questionCategories,
        _value = value,
        _onChanged = onChanged;

  final QuestionCategory? _value;
  final List<QuestionCategory> _questionCategories;
  final void Function(QuestionCategory?) _onChanged;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<QuestionCategory>> categoryItems =
        _questionCategories.map(CategoryMenuItem.build).toList();

    return SizedBox(
      height: 60,
      child: DropdownButtonHideUnderline(
        child: InputDecorator(
          decoration: InputDecoration(labelText: _value != null ? 'Category' : null),
          child: DropdownButton(
            hint: const Text('Category'),
            value: _value,
            items: categoryItems,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            focusColor: Colors.blue,
            onChanged: _onChanged,
          ),
        ),
      ),
    );
  }
}
