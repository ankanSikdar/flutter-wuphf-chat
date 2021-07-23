import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class UserRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;
  final Function onChat;
  final Function onView;
  final Widget online;

  const UserRow({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
    this.onChat,
    this.onView,
    this.date,
    this.online,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onView,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ThemeConfig.smallDpRadius)),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(ThemeConfig.smallDpRadius),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey),
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: InkWell(
                  onTap: onChat,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (online != null) online,
                          if (date != null)
                            Text(
                              date,
                              style: Theme.of(context).textTheme.overline,
                            ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
