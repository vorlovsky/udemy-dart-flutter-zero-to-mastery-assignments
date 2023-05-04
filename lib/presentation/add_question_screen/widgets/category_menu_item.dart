import 'package:flutter/material.dart';
import 'package:task_f9/config/question_category.dart';
import 'package:task_f9/presentation/components/question_category_icon.dart';

class CategoryMenuItem {
  static DropdownMenuItem<QuestionCategory> build(QuestionCategory category) {
    return DropdownMenuItem<QuestionCategory>(
      value: category,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionCategoryIcon(
            category: category,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          Text(category.name),
        ],
      ),
    );
  }
}
