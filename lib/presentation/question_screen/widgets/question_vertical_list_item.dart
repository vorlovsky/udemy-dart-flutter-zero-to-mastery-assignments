import 'package:flutter/material.dart';
import 'package:task_f7/model/question.dart';
import 'package:task_f7/presentation/question_screen/widgets/question_category_icon.dart';

class QuestionVerticalListItem extends StatelessWidget {
  const QuestionVerticalListItem({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionCategoryIcon(category: question.category, width: 70, height: 70),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            question.text,
            maxLines: 2,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )),
        ],
      ),
    );
  }
}
