import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.160),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(125.0),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(125.0),
        child: CachedNetworkImage(
          imageUrl:
              'https://static.wikia.nocookie.net/gtawiki/images/7/70/CJ-GTASA.png/revision/latest/top-crop/width/360/height/360?cb=20190612091918',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(color: Colors.grey),
          errorWidget: (context, url, error) => Container(color: Colors.grey),
        ),
      ),
    );
  }
}
