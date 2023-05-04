import 'package:flutter/material.dart';
import 'package:task_f7/model/question.dart';
import 'package:task_f7/presentation/question_screen/widgets/question_horizontal_list_item.dart';
import 'package:task_f7/presentation/question_screen/widgets/question_vertical_list_item.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({super.key, required this.questions});

  static Axis _getLayoutDirection(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.width > 500 ? Axis.horizontal : Axis.vertical;
  }

  static Widget _getListItem(Question question, Axis layoutDirection) {
    return layoutDirection == Axis.vertical
        ? QuestionVerticalListItem(question: question)
        : QuestionHorizontalListItem(question: question);
  }

  static Widget _getListSeparator(Axis layoutDirection) {
    return layoutDirection == Axis.vertical
        ? const Divider(
            color: Colors.blue,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          )
        : const VerticalDivider(
            color: Colors.blue,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          );
  }

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Center(
        child: Text(
          'Press button below to add a question',
        ),
      );
    }

    Axis layoutDirection = _getLayoutDirection(context);

    return ListView.separated(
      itemCount: questions.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: layoutDirection,
      itemBuilder: (context, index) {
        return _getListItem(questions[index], layoutDirection);
      },
      separatorBuilder: (context, index) {
        return _getListSeparator(layoutDirection);
      },
    );
  }
}
