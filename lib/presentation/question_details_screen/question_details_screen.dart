
import 'package:flutter/material.dart';
import 'package:task_f9/model/question.dart';
import 'package:task_f9/presentation/components/expanded_text_field.dart';
import 'package:task_f9/presentation/components/question_category_icon.dart';
import 'package:task_f9/presentation/question_details_screen/widgets/animated_dialog_container.dart';
import 'package:task_f9/presentation/question_details_screen/widgets/animated_floating_action_button.dart';
import 'package:task_f9/presentation/question_details_screen/widgets/message_dialog.dart';
import 'package:task_f9/presentation/question_details_screen/widgets/messages.dart';
import 'package:task_f9/utils/navigation.dart';
import 'package:task_f9/utils/widgets.dart';

class QuestionDetailsArguments {
  const QuestionDetailsArguments(this.question);

  final Question question;
}

class QuestionDetailsScreen extends StatefulWidget {
  static const String routeName = '/questionDetails';

  const QuestionDetailsScreen({super.key, required this.arguments});

  final QuestionDetailsArguments arguments;

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen>
    with TickerProviderStateMixin {
  _QuestionDetailsScreenState();

  late final Iterator<String> hintsIterator;

  Question get question => widget.arguments.question;

  String answer = '';
  MessageData? messageData;
  bool isInputDisallowed = false;
  
  final GlobalKey _buttonKey = GlobalKey();
  late final AnimationController _buttonAnimationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final AnimationController _hintAnimationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  @override
  void initState() {
    hintsIterator = question.hints;

    super.initState();
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _hintAnimationController.dispose();

    super.dispose();
  }

  void onAnswerPressed() async {
    await _buttonAnimationController.forward();

    setState(() => isInputDisallowed = true);

    checkAnswer();
  }

  void onHintClosed() async {
    await _buttonAnimationController.reverse();

    setState(() => isInputDisallowed = false);
  }

  void checkAnswer() {
    if (answer == question.solution) {
      openCompleteMessage(onClosed: () => popRoute(context));
      return;
    }

    if (hintsIterator.moveNext()) {
      openHint(hintsIterator.current, onClosed: onHintClosed);
    } else {
      openSolution(onClosed: () => popRoute(context));
    }
  }

  void openHint(String hint, {required void Function()? onClosed}) {
    openMessage(
      HintMessage(hint: hint),
      onOpened: () async {
        await Future.delayed(const Duration(seconds: 3));

        closeMessage(onClosed: onClosed);
      },
    );
  }

  void openSolution({required void Function() onClosed}) {
    openMessage(
      SolutionMessage(solution: widget.arguments.question.solution),
      actions: [
        TextButton(
          onPressed: onClosed,
          child: const Text('OK'),
        ),
      ],
    );
  }

  void openCompleteMessage({required void Function() onClosed}) {
    openMessage(
      const CompleteMessage(),
      actions: [
        TextButton(
          onPressed: onClosed,
          child: const Text('OK'),
        ),
      ],
    );
  }

  void openMessage(Widget content, {List<Widget>? actions, void Function()? onOpened}) async {
    setState(() {
      messageData = MessageData(content, actions: actions);
    });

    await _hintAnimationController.forward();

    onOpened?.call();
  }

  void closeMessage({void Function()? onClosed}) async {
    await _hintAnimationController.reverse();

    setState(() {
      messageData = null;
    });

    onClosed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question Details')),
      body: LayoutBuilder(builder: (context, constraints) {
        List<Widget> stackChildren = [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuestionCategoryIcon(category: question.category, width: 70, height: 79),
                  const SizedBox(height: 20),
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(question.text),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    child: const Text('Your answer:'),
                  ),
                  const SizedBox(height: 5),
                  ExpandedTextField(
                    readOnly: isInputDisallowed,
                    onChanged: (value) => setState(
                      () {
                        answer = value.trim();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];

        if (messageData != null) {
          stackChildren.add(
            AnimatedDialogConatiner(
              bounds: constraints.biggest,
              startOffset: getWidgetCenter(_buttonKey.currentContext, context),
              animationController: _hintAnimationController,
              child: MessageDialog(messageData: messageData!),
            ),
          );
        }

        return Stack(
          children: stackChildren,
        );
      }),
      floatingActionButton: AnimatedFloatingActionButton(
        key: _buttonKey,
        animationController: _buttonAnimationController,
        tooltip: 'Answer the question',
        onPressed: onAnswerPressed,
      ),
    );
  }
}
