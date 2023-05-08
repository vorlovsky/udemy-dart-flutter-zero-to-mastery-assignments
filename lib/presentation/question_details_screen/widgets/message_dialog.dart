import 'package:flutter/material.dart';

class MessageData {
  MessageData(this.content, {List<Widget>? actions}) : actions = actions ?? [];

  final Widget content;
  final List<Widget> actions;
}

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    required this.messageData,
  });

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]),
      child: Padding(
        padding: messageData.actions.isNotEmpty
            ? const EdgeInsets.only(left: 30, right: 30, top: 15)
            : const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            messageData.content,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: messageData.actions,
            )
          ],
        ),
      ),
    );
  }
}
