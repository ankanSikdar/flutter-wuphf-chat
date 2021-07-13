import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/screens/chatting/bloc/chatting_bloc.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({Key key}) : super(key: key);

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  void _sendMessage() {
    if (_textEditingController.text.trim().isNotEmpty) {
      context
          .read<ChattingBloc>()
          .add(ChattingSendMessage(message: _textEditingController.text));
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChattingBloc, ChattingState>(
      builder: (context, state) {
        return Material(
          elevation: 8.0,
          shadowColor: Colors.grey[500],
          child: Container(
            height: 70.0,
            child: Column(
              children: [
                if (state.isSending) LinearProgressIndicator(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  margin: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Message...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) {
                            _sendMessage();
                          },
                        ),
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
