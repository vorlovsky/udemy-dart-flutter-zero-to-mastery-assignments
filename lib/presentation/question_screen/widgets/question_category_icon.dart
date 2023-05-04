import 'package:flutter/material.dart';
import 'package:task_f7/config/question_category.dart';

class QuestionCategoryIcon extends StatelessWidget {
  const QuestionCategoryIcon({super.key, required this.category, this.width, this.height});

  final QuestionCategory category;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(width: width, height: height, 'assets/images/icon_${category.name}.png');
  }
}
