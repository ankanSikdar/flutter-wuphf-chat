import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/config/configs.dart';

class DevLink extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;

  const DevLink({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: FaIcon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        label: Text(
          label,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.8, 50.0),
          ),
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
    );
  }
}
