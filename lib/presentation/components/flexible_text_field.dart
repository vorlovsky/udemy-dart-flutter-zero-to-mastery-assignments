import 'package:flutter/material.dart';

class FlexibleTextField extends StatelessWidget {
  const FlexibleTextField({
    super.key,
    String? labelText,
    void Function(String)? onChanged,
    TextEditingController? controller,
    final FocusNode? focusNode,
  })  : _labelText = labelText ?? '',
        _onChanged = onChanged,
        _controller = controller,
        _focusNode = focusNode;

  final String _labelText;
  final void Function(String)? _onChanged;
  final TextEditingController? _controller;
  final FocusNode? _focusNode;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        maxLines: 1,
        decoration: InputDecoration(labelText: _labelText),
        onChanged: _onChanged,
      ),
    );
  }
}
