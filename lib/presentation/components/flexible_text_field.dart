import 'package:flutter/material.dart';

class FlexibleTextField extends StatelessWidget {
  const FlexibleTextField({
    super.key,
    String? labelText,
    void Function(String)? onChanged,
  })  : _labelText = labelText ?? '',
        _onChanged = onChanged;

  final String _labelText;
  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(labelText: _labelText),
        onChanged: _onChanged,
      ),
    );
  }
}
