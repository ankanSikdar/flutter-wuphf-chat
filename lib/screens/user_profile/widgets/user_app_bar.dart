import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({Key key}) : super(key: key);

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
      title: Container(
        child: Row(
          children: [
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
                  imageUrl:
                      'https://www.rollingstone.com/wp-content/uploads/2018/10/green-day-band-portrait.jpg',
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
                  Text(
                    'Ross Geller',
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'ross@friends.com',
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
