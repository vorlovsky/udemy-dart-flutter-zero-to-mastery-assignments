import 'package:flutter/material.dart';
import 'package:task_f9/model/question.dart';

abstract class RootContainerState extends State {
  int currentIndex = 0;

  List<Question> questions = [];

  void addQuestion(Question question, {bool showQuestions = true}) {
    setState(() {
      questions.insert(0, question);

      if (showQuestions) {
        currentIndex = 0;
      }
    });
  }
}
