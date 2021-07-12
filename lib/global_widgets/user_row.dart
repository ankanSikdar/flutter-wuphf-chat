import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  final String title;
  final String subtitle;
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
          GestureDetector(
            onTap: onChat,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
