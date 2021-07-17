import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;

  const MessageTextField({
    Key key,
    @required this.focusNode,
    @required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        controller: textEditingController,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          hintText: 'Message...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
        ),
        minLines: 1,
        maxLines: 3,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
