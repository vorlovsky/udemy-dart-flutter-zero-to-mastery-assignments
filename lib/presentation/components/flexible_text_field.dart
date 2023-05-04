import 'package:flutter/material.dart';

class FlexibleTextField extends StatelessWidget {
  const FlexibleTextField({
    super.key,
    String? labelText,
    void Function(String)? onChanged,
    TextEditingController? controller,
  })  : _labelText = labelText ?? '',
        _onChanged = onChanged,
        _controller = controller;

  final String _labelText;
  final void Function(String)? _onChanged;
  final TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: _controller,
        maxLines: 1,
        decoration: InputDecoration(labelText: _labelText),
        onChanged: _onChanged,
      ),
    );
  }
}
