import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class ProfilePicture extends StatelessWidget {
  final String imageUrl;
  const ProfilePicture({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeConfig.smallDpRadius),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey,
          ),
        ],
      ),
      padding: EdgeInsets.all(3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ThemeConfig.smallDpRadius),
        child: imageUrl.trim().isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey),
                errorWidget: (context, url, error) =>
                    Container(color: Colors.grey),
              )
            : Container(),
      ),
    );
  }
}
