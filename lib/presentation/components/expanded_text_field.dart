import 'package:flutter/material.dart';

class ExpandedTextField extends StatelessWidget {
  const ExpandedTextField({super.key, this.readOnly = false, this.onChanged});

  final bool readOnly;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
          autofocus: true,
          expands: true,
          maxLines: null,
          minLines: null,
          readOnly: readOnly,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), contentPadding: EdgeInsets.all(5)),
          textAlignVertical: TextAlignVertical.top,
          onChanged: onChanged),
    );
  }
}
