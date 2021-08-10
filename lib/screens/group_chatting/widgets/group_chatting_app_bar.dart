import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class GroupChattingAppBar extends StatelessWidget {
  const GroupChattingAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      shadowColor: Colors.grey[500],
      backgroundColor: Colors.white,
      toolbarHeight: 100,
      floating: true,
      pinned: true,
      forceElevated: true,
      automaticallyImplyLeading: false,
      leadingWidth: 35.0,
      titleSpacing: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(ThemeConfig.borderRadius),
        ),
      ),
    );
  }
}
