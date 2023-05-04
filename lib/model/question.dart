import 'package:task_f9/config/question_category.dart';

class Question {
  final QuestionCategory _category;
  final String _text;
  final String _solution;
  final List<String> _hints;

  QuestionCategory get category => _category;
  String get text => _text;
  String get solution => _solution;
  Iterator<String> get hints => _hints.iterator;

  Question(
      {required final QuestionCategory category,
      required final String text,
      required String solution,
      List<String>? hints})
      : _category = category,
        _text = text,
        _solution = solution,
        _hints = hints ?? [];
}
