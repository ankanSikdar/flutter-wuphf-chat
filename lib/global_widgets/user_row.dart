import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;
  final Function onChat;
  final Function onView;

  const UserRow({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
    this.onChat,
    this.onView,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onView,
            child: Container(
              height: 70,
              width: 70,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(35.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
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
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (date != null) Text(date),
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
    );
  }
}
