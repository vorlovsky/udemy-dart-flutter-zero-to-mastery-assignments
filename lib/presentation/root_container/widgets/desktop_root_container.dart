import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:task_f9/presentation/add_question_screen/add_question_screen.dart';
import 'package:task_f9/presentation/questions_screen/questions_screen.dart';
import 'package:task_f9/presentation/root_container/widgets/root_container_state.dart';

class DesktopRootContainer extends StatefulWidget {
  const DesktopRootContainer({super.key});

  @override
  RootContainerState createState() => _DesktopRootContainerState();
}

class _DesktopRootContainerState extends RootContainerState {
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
