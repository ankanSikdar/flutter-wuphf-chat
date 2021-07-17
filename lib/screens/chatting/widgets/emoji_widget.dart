import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiWidget extends StatelessWidget {
  final Function onEmojiSelected;
  final Function onBackspacePressed;

  const EmojiWidget(
      {Key key,
      @required this.onEmojiSelected,
      @required this.onBackspacePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: onEmojiSelected,
      onBackspacePressed: onBackspacePressed,
      config: const Config(
        columns: 7,
        emojiSizeMax: 32.0,
        verticalSpacing: 0,
        horizontalSpacing: 0,
        initCategory: Category.RECENT,
        bgColor: Color(0xFFF2F2F2),
        indicatorColor: Colors.blue,
        iconColor: Colors.grey,
        iconColorSelected: Colors.blue,
        progressIndicatorColor: Colors.blue,
        backspaceColor: Colors.blue,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecentsText: 'No Recents',
        noRecentsStyle: TextStyle(fontSize: 20, color: Colors.black26),
        categoryIcons: CategoryIcons(),
        // buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}
