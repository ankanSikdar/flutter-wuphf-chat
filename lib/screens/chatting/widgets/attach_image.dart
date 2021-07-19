import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AttachImage extends StatefulWidget {
  const AttachImage({
    Key key,
  }) : super(key: key);

  @override
  _AttachImageState createState() => _AttachImageState();
}

class _AttachImageState extends State<AttachImage> {
  final _picker = ImagePicker();

  Future<void> _pickImage(ImageSource imageSource) async {
    final pickedFile = await _picker.getImage(
      source: imageSource,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio7x5,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Select an Image',
          toolbarColor: Theme.of(context).accentColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: Theme.of(context).primaryColor,
        ),
        iosUiSettings:
            IOSUiSettings(title: 'Select an Image', doneButtonTitle: 'Send'),
      );
      if (croppedFile != null) {
        Navigator.of(context).pop(croppedFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              _pickImage(ImageSource.camera);
            },
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          SizedBox(width: 16.0),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
