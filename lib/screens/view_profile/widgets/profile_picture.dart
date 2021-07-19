import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String imageUrl;

  const ProfilePictureWidget({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ThemeConfig.dpRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(color: Colors.grey),
          errorWidget: (context, url, error) => Container(color: Colors.grey),
        ),
      ),
    );
  }
}
