import 'package:flutter/material.dart';
import 'package:task_f8/model/question.dart';
import 'package:task_f8/presentation/question_screen/widgets/question_horizontal_list_item.dart';
import 'package:task_f8/presentation/question_screen/widgets/question_vertical_list_item.dart';
import 'package:task_f8/presentation/question_screen/widgets/questions_list_divider.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList(
      {super.key,
      required List<Question> questions,
      required void Function(Question) onSelectQuestion})
      : _questions = questions,
        _onSelectQuestion = onSelectQuestion;

  final List<Question> _questions;
  final void Function(Question) _onSelectQuestion;

  static Axis _getLayoutDirection(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.width > 500 ? Axis.horizontal : Axis.vertical;
  }

  Widget _buildListItem(Question question, Axis layoutDirection) {
    return GestureDetector(
      onTap: () => _onSelectQuestion(question),
      child: layoutDirection == Axis.vertical
          ? QuestionVerticalListItem(question: question)
          : QuestionHorizontalListItem(question: question),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Center(
        child: Text(
          'Press button below to add a question',
        ),
      );
    }

    Axis layoutDirection = _getLayoutDirection(context);

    return ListView.separated(
      itemCount: _questions.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: layoutDirection,
      itemBuilder: (context, index) => _buildListItem(_questions[index], layoutDirection),
      separatorBuilder: (context, index) => QuestionsListDivider(layoutDirection: layoutDirection),
    );
  }
}
