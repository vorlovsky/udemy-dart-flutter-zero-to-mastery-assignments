import 'package:task_f7/config/question_category.dart';

class Question {
  late final QuestionCategory _category;
  late final String _text;

  QuestionCategory get category => _category;
  String get text => _text;

  Question({required final QuestionCategory category, required final String text})
      : _category = category,
        _text = text;
}
