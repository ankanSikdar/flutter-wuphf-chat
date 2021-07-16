import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/screens.dart';

class ChattingAppBar extends StatelessWidget {
  final User user;

  const ChattingAppBar({Key key, @required this.user}) : super(key: key);

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
      title: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ViewProfileScreen.routeName,
            arguments: ViewProfileScreenArgs(user: user),
          );
        },
        child: Container(
          child: Row(
            children: [
              SizedBox(width: 8.0),
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35.0),
                  child: CachedNetworkImage(
                    imageUrl: user.profileImageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey),
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
                    Text(
                      user.displayName,
                      style: Theme.of(context).textTheme.headline5,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.navigate_before,
        ),
      ),
    );
  }
}
