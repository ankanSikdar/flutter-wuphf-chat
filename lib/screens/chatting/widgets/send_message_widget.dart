import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:wuphf_chat/screens/chatting/widgets/attach_image.dart';
import 'package:wuphf_chat/screens/chatting/widgets/emoji_widget.dart';
import 'package:wuphf_chat/screens/chatting/widgets/message_text_field.dart';

class SendMessageWidget extends StatefulWidget {
  final Function({String message, File imageFile}) onSend;
  final bool isSending;

  const SendMessageWidget(
      {Key key, @required this.onSend, @required this.isSending})
      : super(key: key);

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  TextEditingController _textEditingController;
  FocusNode _focusNode;
  File imageFile;

  bool emojiShowing = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textEditingController.text.trim().isNotEmpty || imageFile != null) {
      widget.onSend(
        message: _textEditingController.text.trim(),
        imageFile: imageFile,
      );
      _textEditingController.clear();
      setState(() {
        imageFile = null;
      });
    }
  }

  void _onEmojiSelected(emoji) {
    _textEditingController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
  }

  void _onBackspacePressed() {
    _textEditingController
      ..text = _textEditingController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
  }

  void _onEmojiButtonPressed() {
    setState(() {
      if (emojiShowing) {
        emojiShowing = false;
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
        emojiShowing = true;
      }
    });
  }

  void _onAttachButtonPressed() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AttachImage(),
    ).then((image) {
      if (image != null) {
        setState(() {
          imageFile = image;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      shadowColor: Colors.grey[500],
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(ThemeConfig.borderRadius),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isSending) LinearProgressIndicator(),
            if (!widget.isSending && imageFile != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100.0,
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ThemeConfig.borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ThemeConfig.borderRadius),
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(
                        () {
                          imageFile = null;
                        },
                      );
                    },
                  )
                ],
              ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: FaIcon(
                      emojiShowing
                          ? FontAwesomeIcons.solidKeyboard
                          : FontAwesomeIcons.solidSmile,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _onEmojiButtonPressed,
                  ),
                  MessageTextField(
                    focusNode: _focusNode,
                    textEditingController: _textEditingController,
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.paperclip,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _onAttachButtonPressed,
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
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: EmojiWidget(
                  onBackspacePressed: _onBackspacePressed,
                  onEmojiSelected: (Category category, Emoji emoji) {
                    _onEmojiSelected(emoji);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
