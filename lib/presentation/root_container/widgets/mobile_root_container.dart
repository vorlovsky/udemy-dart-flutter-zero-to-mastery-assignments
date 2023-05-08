import 'package:flutter/material.dart';
import 'package:task_f9/presentation/add_question_screen/add_question_screen.dart';
import 'package:task_f9/presentation/questions_screen/questions_screen.dart';
import 'package:task_f9/presentation/root_container/widgets/root_container_state.dart';

class MobileRootContainer extends StatefulWidget {
  const MobileRootContainer({super.key});

  @override
  RootContainerState createState() => _MobileRootContainerState();
}

class _MobileRootContainerState extends RootContainerState {
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
