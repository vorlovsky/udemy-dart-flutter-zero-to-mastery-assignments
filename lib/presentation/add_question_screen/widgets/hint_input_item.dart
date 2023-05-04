import 'package:flutter/material.dart';
import 'package:task_f9/presentation/components/flexible_text_field.dart';

class HintInputItem extends StatelessWidget {
  const HintInputItem(
      {super.key, required void Function(String) onChanged, required void Function() onRemove})
      : _onChanged = onChanged,
        _onRemove = onRemove;

  final void Function(String) _onChanged;
  final void Function() _onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FlexibleTextField(
          labelText: 'Hint text',
          onChanged: _onChanged,
        ),
        IconButton(
          constraints: BoxConstraints.tight(const Size(40, 40)),
          onPressed: _onRemove,
          style:
              ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)),
          icon: const Icon(Icons.cancel, color: Colors.blue),
        ),
      ],
    );
  }
}
