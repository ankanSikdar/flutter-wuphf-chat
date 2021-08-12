import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/config/theme_config.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/helper/time_helper.dart';
import 'package:wuphf_chat/screens/screens.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isAuthor;
  final String name;

  const MessageWidget({
    Key key,
    @required this.message,
    @required this.isAuthor,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marginSide = MediaQuery.of(context).size.width * 0.3;
    return Container(
      margin: isAuthor
          ? EdgeInsets.fromLTRB(marginSide, 0.0, 8.0, 16.0)
          : EdgeInsets.fromLTRB(8.0, 0.0, marginSide, 16.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: isAuthor
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: ThemeConfig.userMessageColors,
              )
            : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: ThemeConfig.recipientMessageColors,
              ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ThemeConfig.borderRadius),
          topRight: Radius.circular(ThemeConfig.borderRadius),
          bottomLeft: Radius.circular(isAuthor ? ThemeConfig.borderRadius : 0),
          bottomRight: Radius.circular(isAuthor ? 0 : ThemeConfig.borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(4, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (name != null && !isAuthor)
            Container(
              child: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .apply(color: ThemeConfig.recipientNameColor),
              ),
            ),
          if (message.imageUrl != null && message.imageUrl.trim().isNotEmpty)
            Container(
              height: 200.0,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ViewImageScreen.routeName,
                    arguments: ViewImageScreenArgs(imageUrl: message.imageUrl),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ThemeConfig.borderRadius),
                  child: CachedNetworkImage(
                    imageUrl: message.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey),
                    errorWidget: (context, url, error) =>
                        Container(color: Colors.grey),
                  ),
                ),
              ),
            ),
          if (message.text.trim().isNotEmpty)
            Text(
              message.text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                message.sentAt.forMessages(),
                style: Theme.of(context).textTheme.overline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
