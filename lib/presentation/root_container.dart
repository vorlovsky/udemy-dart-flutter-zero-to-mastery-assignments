import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:task_f9/model/question.dart';
import 'package:task_f9/presentation/add_question_screen/add_question_screen.dart';
import 'package:task_f9/presentation/question_screen/questions_screen.dart';

class RootContainer extends StatefulWidget {
  static const String routeName = '/root';

  const RootContainer({super.key});

  static bool get isMobilePlatform => (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android);

  @override
  State<RootContainer> createState() =>
      isMobilePlatform ? _MobileRootContainerState() : _DesktopRootContainerState();
}

abstract class _RootContainerState extends State<RootContainer> {
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

class _DesktopRootContainerState extends _RootContainerState {
  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      QuestionsScreen(arguments: QuestionsArguments(questions)),
      AddQuestionScreen(arguments: AddQuestionArguments(onAdd: addQuestion)),
    ];

    return Scaffold(
      body: Row(
        children: [
          SideNavigationBar(
            selectedIndex: currentIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.list,
                label: 'Questions List',
              ),
              SideNavigationBarItem(
                icon: Icons.add,
                label: 'Add Question',
              ),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            toggler: const SideBarToggler(
              expandIcon: Icons.keyboard_arrow_right,
              shrinkIcon: Icons.keyboard_arrow_left,
            ),
            initiallyExpanded: false,
          ),
          Expanded(
            child: views.elementAt(currentIndex),
          ),
        ],
      ),
    );
  }
}

class _MobileRootContainerState extends _RootContainerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          QuestionsScreen(arguments: QuestionsArguments(questions)),
          AddQuestionScreen(arguments: AddQuestionArguments(onAdd: addQuestion)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
                currentIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Questions List'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Question'),
          ]),
    );
  }
}
