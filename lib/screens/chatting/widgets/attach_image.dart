import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceIcon(
            label: 'Camera',
            icon: FontAwesomeIcons.camera,
            onTap: () {
              _pickImage(ImageSource.camera);
            },
          ),
          SizedBox(width: 32.0),
          ChoiceIcon(
            label: 'Gallery',
            icon: FontAwesomeIcons.solidImages,
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          SizedBox(width: 32.0),
          IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).hintColor,
                size: 28.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}

class ChoiceIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  const ChoiceIcon(
      {Key key,
      @required this.label,
      @required this.icon,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: FaIcon(
              icon,
              size: 28,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
