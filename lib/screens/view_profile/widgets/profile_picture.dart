import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/screens/screens.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String imageUrl;
  final bool isClipped;

  const ProfilePictureWidget(
      {Key key, @required this.imageUrl, this.isClipped = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ViewImageScreen.routeName,
          arguments: ViewImageScreenArgs(imageUrl: imageUrl),
        );
      },
      child: Container(
        height: 250,
        width: 250,
        child: isClipped
            ? ClipRRect(
                borderRadius: BorderRadius.circular(ThemeConfig.dpRadius),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) =>
                      Container(color: Colors.grey),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitHeight,
                placeholder: (context, url) => Container(color: Colors.grey),
                errorWidget: (context, url, error) =>
                    Container(color: Colors.grey),
              ),
      ),
    );
  }
}
