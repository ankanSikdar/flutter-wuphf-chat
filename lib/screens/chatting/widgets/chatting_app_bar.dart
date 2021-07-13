import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/models/models.dart';

class ChattingAppBar extends StatelessWidget {
  final User user;

  const ChattingAppBar({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 100,
      title: Container(
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(35.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35.0),
                child: CachedNetworkImage(
                  imageUrl: user.profileImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) =>
                      Container(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName),
                  SizedBox(height: 8.0),
                  Text(user.email),
                ],
              ),
            ),
          ],
        ),
      ),
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
    );
  }
}
