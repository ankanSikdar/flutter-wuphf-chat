import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/config/configs.dart';

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final Color buttonColor;
  final String title;
  final Color titleColor;
  final Size size;

  const CustomElevatedButton({
    Key key,
    @required this.icon,
    @required this.onTap,
    @required this.buttonColor,
    @required this.title,
    @required this.titleColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: FaIcon(icon),
        label: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            size ?? Size(MediaQuery.of(context).size.width * 0.35, 50.0),
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
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      ),
    );
  }
}
