import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfilePictureWidget extends StatefulWidget {
  ProfilePictureWidget({Key key, @required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  final _picker = ImagePicker();
  File file;

  _ProfilePictureWidgetState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedFile = await _picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );
        if (pickedFile != null) {
          final croppedFile = await ImageCropper.cropImage(
            sourcePath: pickedFile.path,
            aspectRatioPresets: [CropAspectRatioPreset.square],
            androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Profile Picture',
              toolbarColor: Theme.of(context).accentColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
            ),
            iosUiSettings: IOSUiSettings(
              title: 'Profile Picture',
            ),
          );
          if (croppedFile != null) {
            setState(() {
              file = croppedFile;
            });
          }
        }
      },
      child: Container(
        height: 250,
        width: 250,
        // margin:
        // EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(125.0),
          color: Colors.grey[200],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(125.0),
          child: file == null
              ? CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) =>
                      Container(color: Colors.grey),
                )
              : Container(
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
