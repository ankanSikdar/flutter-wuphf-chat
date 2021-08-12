import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

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
        bgColor: ThemeConfig.emojiWidgetBackgroundColor,
        indicatorColor: ThemeConfig.emojiWidgetPrimaryColor,
        iconColor: ThemeConfig.emojiWidgetIconColor,
        iconColorSelected: ThemeConfig.emojiWidgetPrimaryColor,
        progressIndicatorColor: ThemeConfig.emojiWidgetPrimaryColor,
        backspaceColor: ThemeConfig.emojiWidgetPrimaryColor,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecentsText: 'No Recents',
        categoryIcons: CategoryIcons(),
        // buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}
