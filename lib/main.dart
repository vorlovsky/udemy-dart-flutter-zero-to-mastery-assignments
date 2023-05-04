import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task F2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuestionsPage(),
    );
  }
}

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  static const List<String> questionCategories = ['Category 1', 'Category 2', 'Category 3'];

  List<Question> questions = [];

  static QuestionWidget questionMapper(Question question) => QuestionWidget(question: question);

  void _addQuestion(Question question) {
    setState(() {
      questions.add(question);
    });
  }

  void _showAddQuestionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AddQuestionDialog(questionCategories: questionCategories, onAdd: _addQuestion));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions Page'),
      ),
      body: questions.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: questions.map(questionMapper).toList(),
              ),
            )
          : const Center(
              child: Text(
                'Press button below to add a question',
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddQuestionDialog(context),
        tooltip: 'Add question',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddQuestionDialog extends StatefulWidget {
  static DropdownMenuItem<String> questionCategoryMapper(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }

  final List<DropdownMenuItem<String>> categoryItems;
  final void Function(Question) onAdd;

  AddQuestionDialog({super.key, required List<String> questionCategories, required this.onAdd})
      : categoryItems = questionCategories.map(questionCategoryMapper).toList();

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  String? questionCategory;
  String? questionText;

  bool get _isAllDataProvided =>
      questionCategory != null && questionText != null && questionText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter question data:'),
      elevation: 5,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60,
            child: DropdownButtonHideUnderline(
              child: InputDecorator(
                decoration:
                    InputDecoration(labelText: questionCategory != null ? 'Category' : null),
                child: DropdownButton(
                  hint: const Text('Category'),
                  value: questionCategory,
                  items: widget.categoryItems,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  focusColor: Colors.blue,
                  onChanged: (value) => setState(() => questionCategory = value),
                ),
              ),
            ),
          ),
          Flexible(
              child: TextField(
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Question text'),
            onChanged: (value) => setState(() => questionText = value),
          ))
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: _isAllDataProvided
              ? () {
                  widget.onAdd(Question(category: questionCategory!, text: questionText!));

                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10.0),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blue, width: 1))),
      child: Row(
        children: [
          Text(question.category),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            question.text,
            maxLines: 2,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )),
        ],
      ),
    );
  }
}

class Question {
  late final String _category;
  late final String _text;

  String get category => _category;
  String get text => _text;

  Question({required final String category, required final String text})
      : _category = category,
        _text = text;
}
