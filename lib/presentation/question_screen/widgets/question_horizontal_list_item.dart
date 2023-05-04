import 'package:flutter/material.dart';
import 'package:task_f9/model/question.dart';
import 'package:task_f9/presentation/components/question_category_icon.dart';

class QuestionHorizontalListItem extends StatelessWidget {
  const QuestionHorizontalListItem({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionCategoryIcon(
            category: question.category,
            width: 70,
            height: 70,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            question.text,
          )),
        ],
      ),
    );
  }
}
