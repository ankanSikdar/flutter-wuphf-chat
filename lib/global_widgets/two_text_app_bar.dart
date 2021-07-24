import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class TwoTextAppBar extends StatelessWidget {
  final String title;
  final String subtitle;

  const TwoTextAppBar({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(ThemeConfig.borderRadius),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.0),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.navigate_before),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
