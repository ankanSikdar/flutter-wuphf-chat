import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/screens.dart';

class UserAppBar extends StatelessWidget {
  final String email;
  final String displayName;
  final String profileImageUrl;

  const UserAppBar({
    Key key,
    @required this.email,
    @required this.displayName,
    @required this.profileImageUrl,
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
      title: Container(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ViewImageScreen.routeName,
                  arguments: ViewImageScreenArgs(imageUrl: profileImageUrl),
                );
              },
              child: ProfilePicture(
                imageUrl: profileImageUrl,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    email,
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
    );
  }
}
