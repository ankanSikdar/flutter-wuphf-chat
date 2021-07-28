import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/config/configs.dart';

class SelectingFAB extends StatelessWidget {
  final Function onCreate;
  final Function onCancel;
  const SelectingFAB({
    Key key,
    @required this.onCreate,
    @required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: onCreate,
          icon: FaIcon(
            FontAwesomeIcons.peopleArrows,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Create a Group',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(4.0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(16.0),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(ThemeConfig.borderRadius),
                ),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onCancel,
          icon: FaIcon(
            FontAwesomeIcons.times,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(4.0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(16.0),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(ThemeConfig.borderRadius),
                ),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ],
    );
  }
}
